{
  config,
  lib,
  pkgs,
  ...
}: let
  topicFile = "${config.xdg.configHome}/notification-forwarding/ntfy-topic";
  python = pkgs.python3.withPackages (pythonPackages: [pythonPackages.dbus-next]);
  agentNotificationHandler = pkgs.writeTextFile {
    name = "locked-agent-notification";
    destination = "/bin/locked-agent-notification";
    executable = true;
    text = ''
      #!${pkgs.python3}/bin/python3
      import fcntl
      import json
      import os
      import subprocess
      import sys
      import tempfile
      from pathlib import Path

      VALID_STATUSES = {"idle", "working", "blocked", "done", "unknown"}


      def read_json_environment(name):
          try:
              value = json.loads(os.environ.get(name, "{}"))
          except json.JSONDecodeError as error:
              raise ValueError(f"invalid {name}: {error}") from error
          if not isinstance(value, dict):
              raise ValueError(f"{name} must contain a JSON object")
          return value


      def load_state(path):
          try:
              value = json.loads(path.read_text(encoding="utf-8"))
          except FileNotFoundError:
              return {}
          except (OSError, json.JSONDecodeError) as error:
              raise RuntimeError(f"cannot read plugin state from {path}: {error}") from error
          if not isinstance(value, dict):
              raise ValueError(f"plugin state in {path} must contain a JSON object")
          return value


      def save_state(path, state):
          with tempfile.NamedTemporaryFile(
              mode="w",
              encoding="utf-8",
              dir=path.parent,
              prefix=f".{path.name}.",
              delete=False,
          ) as temporary:
              json.dump(state, temporary, sort_keys=True)
              temporary.write("\n")
              temporary_path = Path(temporary.name)
          temporary_path.chmod(0o600)
          temporary_path.replace(path)


      def notification_for(previous, agent, status):
          if previous.get("agent") not in {None, agent}:
              previous = {}
          armed = bool(previous.get("armed", False))
          if status in {"working", "blocked", "unknown"}:
              return {"agent": agent, "armed": agent is not None, "status": status}, None
          if status == "idle" and armed:
              return {"agent": agent, "armed": False, "status": status}, "finished"
          return {"agent": agent, "armed": False if status == "done" else armed, "status": status}, None


      def main():
          if len(sys.argv) != 3:
              raise ValueError("expected systemctl and notify-send executable paths")

          systemctl, notify_send = sys.argv[1:]
          event = read_json_environment("HERDR_PLUGIN_EVENT_JSON")
          context = read_json_environment("HERDR_PLUGIN_CONTEXT_JSON")
          data = event.get("data", event)
          if not isinstance(data, dict):
              raise ValueError("HERDR_PLUGIN_EVENT_JSON data must be an object")

          pane_id = data.get("pane_id")
          if not isinstance(pane_id, str) or not pane_id:
              raise ValueError("Herdr event is missing pane_id")

          state_dir_value = os.environ.get("HERDR_PLUGIN_STATE_DIR")
          if not state_dir_value:
              raise ValueError("HERDR_PLUGIN_STATE_DIR is not set")
          state_dir = Path(state_dir_value)
          state_dir.mkdir(mode=0o700, parents=True, exist_ok=True)
          state_dir.chmod(0o700)
          state_path = state_dir / "agent-status.json"

          with (state_dir / "agent-status.lock").open("a+") as lock:
              os.fchmod(lock.fileno(), 0o600)
              fcntl.flock(lock, fcntl.LOCK_EX)
              state = load_state(state_path)

              status = data.get("agent_status")
              if status not in VALID_STATUSES:
                  raise ValueError(f"invalid Herdr agent status: {status!r}")

              next_state, message = notification_for(state.get(pane_id, {}), data.get("agent"), status)
              state[pane_id] = next_state
              save_state(state_path, state)

              if message is None:
                  return
              locked = subprocess.run(
                  [systemctl, "--user", "is-active", "--quiet", "notification-forwarding.service"],
                  check=False,
              ).returncode == 0
              if not locked:
                  return

              workspace = context.get("workspace_label") or data.get("workspace_id") or "workspace"
              tab = context.get("tab_label")
              location = f"{workspace} · {tab}" if tab and not str(tab).isdigit() else str(workspace)
              agent = data.get("agent") or "agent"
              subprocess.run(
                  [notify_send, "--", f"{agent} {message}", location],
                  check=True,
              )


      if __name__ == "__main__":
          try:
              main()
          except Exception as error:
              print(f"locked-agent-notification: {error}", file=sys.stderr)
              raise SystemExit(1)
    '';
  };
  herdrPlugin = pkgs.writeTextDir "herdr-plugin.toml" ''
    id = "local.locked-agent-notifications"
    name = "Locked agent notifications"
    version = "1.0.0"
    min_herdr_version = "0.7.0"
    description = "Emit desktop notifications for agent state changes while notification forwarding is active."
    platforms = ["linux"]

    [[events]]
    on = "pane.agent_status_changed"
    command = ["${lib.getExe agentNotificationHandler}", "${lib.getExe' pkgs.systemd "systemctl"}", "${lib.getExe' pkgs.libnotify "notify-send"}"]
  '';
  forwarder = pkgs.writeTextFile {
    name = "notification-forwarding";
    destination = "/bin/notification-forwarding";
    executable = true;
    text = ''
      #!${python}/bin/python3
      import asyncio
      import json
      import os
      import re
      import signal
      import socket
      import stat
      import sys
      import time
      import urllib.request
      from pathlib import Path

      from dbus_next import Message, MessageType
      from dbus_next.aio import MessageBus

      TOPIC_FILE = Path(${builtins.toJSON topicFile})
      TOPIC_PATTERN = re.compile(r"[-_A-Za-z0-9]{1,64}")
      NTFY_URL = "https://ntfy.sh/"


      def read_topic():
          try:
              mode = stat.S_IMODE(TOPIC_FILE.stat().st_mode)
              if mode & 0o077:
                  raise ValueError(f"{TOPIC_FILE} must not be accessible by group or others")
              topic = TOPIC_FILE.read_text(encoding="utf-8").strip()
          except OSError as error:
              raise RuntimeError(f"cannot read ntfy topic from {TOPIC_FILE}: {error}") from error

          if not TOPIC_PATTERN.fullmatch(topic):
              raise ValueError("ntfy topic must contain 1-64 letters, numbers, underscores, or dashes")
          return topic


      def notify_ready():
          address = os.environ.get("NOTIFY_SOCKET")
          if not address:
              return
          if address.startswith("@"):
              address = "\0" + address[1:]
          with socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM) as notifier:
              notifier.sendto(b"READY=1", address)


      def publish(topic, app_name, summary):
          payload = json.dumps({
              "topic": topic,
              "title": app_name or "Desktop",
              "message": summary or "Desktop notification",
          }).encode("utf-8")
          request = urllib.request.Request(
              NTFY_URL,
              data=payload,
              headers={"Content-Type": "application/json", "User-Agent": "notification-forwarding"},
              method="POST",
          )
          with urllib.request.urlopen(request, timeout=10) as response:
              response.read()


      async def main():
          topic = read_topic()
          bus = await MessageBus().connect()
          tasks = set()
          recent = {}

          def handle_message(message):
              if (
                  message.message_type != MessageType.METHOD_CALL
                  or message.interface != "org.freedesktop.Notifications"
                  or message.member != "Notify"
                  or len(message.body) != 8
              ):
                  return False

              app_name, _, _, summary, _, _, _, _ = message.body
              key = (app_name, summary)
              now = time.monotonic()
              if now - recent.get(key, 0) < 0.5:
                  return True
              recent[key] = now

              async def send():
                  try:
                      await asyncio.to_thread(publish, topic, app_name, summary)
                  except Exception as error:
                      print(f"notification-forwarding: ntfy request failed: {error}", file=sys.stderr)

              task = asyncio.create_task(send())
              tasks.add(task)
              task.add_done_callback(tasks.discard)
              return True

          bus.add_message_handler(handle_message)
          reply = await bus.call(Message(
              destination="org.freedesktop.DBus",
              path="/org/freedesktop/DBus",
              interface="org.freedesktop.DBus.Monitoring",
              member="BecomeMonitor",
              signature="asu",
              body=[["type='method_call',interface='org.freedesktop.Notifications',member='Notify'"], 0],
          ))
          if reply.message_type == MessageType.ERROR:
              raise RuntimeError(f"could not monitor desktop notifications: {reply.error_name}")

          stop = asyncio.Event()
          asyncio.get_running_loop().add_signal_handler(signal.SIGTERM, stop.set)
          notify_ready()
          disconnected = asyncio.create_task(bus.wait_for_disconnect())
          stopping = asyncio.create_task(stop.wait())
          await asyncio.wait({disconnected, stopping}, return_when=asyncio.FIRST_COMPLETED)
          if stop.is_set():
              await asyncio.sleep(0.1)
              bus.remove_message_handler(handle_message)
              if tasks:
                  await asyncio.gather(*tasks)
              bus.disconnect()
              await disconnected
          else:
              stopping.cancel()


      if __name__ == "__main__":
          try:
              asyncio.run(main())
          except Exception as error:
              print(f"notification-forwarding: {error}", file=sys.stderr)
              raise SystemExit(1)
    '';
  };
in {
  home.activation = {
    initializeNotificationForwardingTopic = lib.hm.dag.entryAfter ["writeBoundary"] ''
      topic_file=${lib.escapeShellArg topicFile}
      topic_dir="$(${lib.getExe' pkgs.coreutils "dirname"} "$topic_file")"
      ${lib.getExe' pkgs.coreutils "install"} -d -m 0700 "$topic_dir"
      ${lib.getExe' pkgs.coreutils "chmod"} 0700 "$topic_dir"
      if [[ ! -e "$topic_file" ]]; then
        umask 077
        topic="$(${lib.getExe' pkgs.coreutils "tr"} -d - </proc/sys/kernel/random/uuid)$(${lib.getExe' pkgs.coreutils "tr"} -d - </proc/sys/kernel/random/uuid)"
        printf '%s\n' "$topic" > "$topic_file"
      fi
      ${lib.getExe' pkgs.coreutils "chmod"} 0600 "$topic_file"
    '';
    reconcileNotificationForwardingHerdrPlugin = lib.hm.dag.entryAfter ["linkGeneration"] ''
      ${lib.getExe config.programs.herdr.package} plugin link ${lib.escapeShellArg "${config.xdg.configHome}/herdr/managed-plugins/locked-agent-notifications"} --enabled >/dev/null
    '';
  };

  programs.noctalia.settings.hooks = {
    session_locked = "systemctl --user start notification-forwarding.service";
    session_unlocked = "systemctl --user stop notification-forwarding.service";
  };

  systemd.user.services.notification-forwarding = {
    Unit.Description = "Forward desktop notification titles to ntfy";
    Service = {
      ExecStart = lib.getExe forwarder;
      Restart = "on-failure";
      RestartSec = 1;
      Type = "notify";
    };
  };

  xdg.configFile."herdr/managed-plugins/locked-agent-notifications".source = herdrPlugin;
}
