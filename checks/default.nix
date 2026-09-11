{
  darwinModules,
  home-manager,
  homeManagerModules,
  inputs,
  nixosModules,
  nixpkgs,
  pkgs,
}: let
  inherit (nixpkgs) lib;

  mkNixos = modules:
    lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [nixosModules.default] ++ modules;
    };

  mkDarwin = modules:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules =
        [
          darwinModules.default
          {nixpkgs.hostPlatform = "aarch64-darwin";}
        ]
        ++ modules;
    };

  homeBase = {
    home = {
      username = "test";
      homeDirectory = "/home/test";
      stateVersion = "25.05";
    };
  };

  mkHome = modules:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs;};
      modules = [homeManagerModules.default homeBase] ++ modules;
    };

  disabledNixos = mkNixos [];
  invalidSsh = mkNixos [
    {
      my.remote.ssh = {
        enable = true;
        user = "test";
      };
    }
  ];
  overriddenGaming = mkNixos [
    {
      my.gaming.enable = true;
      programs.steam.enable = false;
    }
  ];

  disabledDarwin = mkDarwin [];
  overriddenAerospace = mkDarwin [
    {
      my.aerospace.enable = true;
      services.aerospace.settings.mode.main.binding."cmd-f" = "layout floating tiling";
    }
  ];

  disabledHome = mkHome [];
  enabledNotificationForwarding = mkHome [
    {
      imports = [
        ../homes/x86_64-linux/turing/notification-forwarding.nix
        inputs.stylix.homeModules.stylix
      ];
      my.graphics.enable = true;
      programs.herdr.enable = true;
      xdg.configHome = "/build/module-contracts-notification";
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/espresso.yaml";
      };
    }
  ];
  overriddenDevelopment = mkHome [
    {
      my.development = {
        enable = true;
        git = {
          email = "test@example.com";
          name = "Test User";
        };
      };
      programs.nixvim.opts.number = false;
    }
  ];
  overriddenTerminal = mkHome [
    {
      my.terminal.enable = true;
      programs.fish.enable = false;
    }
  ];

  findAssertion = message: assertions:
    lib.findFirst (candidate: candidate.message == message) null assertions;

  notificationActivation = enabledNotificationForwarding.config.home.activation.initializeNotificationForwardingTopic.data;
  notificationTopicDirectory = "/build/module-contracts-notification/notification-forwarding";
  notificationTopicFile = "${notificationTopicDirectory}/ntfy-topic";
  notificationHerdrPlugin = enabledNotificationForwarding.config.xdg.configFile."herdr/managed-plugins/locked-agent-notifications".source;
  notificationFakeSystemctl = pkgs.writeShellScript "notification-fake-systemctl" ''
    [[ "''${LOCKED:-0}" == 1 ]]
  '';
  notificationFakeNotify = pkgs.writeShellScript "notification-fake-notify" ''
    printf '%s\n' "$*" >> "$NOTIFICATIONS"
  '';
  sshAssertion =
    findAssertion
    "my.remote.ssh.user and my.remote.ssh.keyDirectory must be set together."
    invalidSsh.config.assertions;
in
  assert !disabledNixos.config.services.openssh.enable;
  assert !disabledNixos.config.programs.steam.enable;
  assert sshAssertion != null && !sshAssertion.assertion;
  assert !overriddenGaming.config.programs.steam.enable;
  assert !disabledDarwin.config.services.aerospace.enable;
  assert overriddenAerospace.config.services.aerospace.settings.mode.main.binding."cmd-f" == "layout floating tiling";
  assert !disabledHome.config.programs.fish.enable;
  assert !disabledHome.config.programs.git.enable;
  assert !disabledHome.config.programs.nixvim.enable;
  assert enabledNotificationForwarding.config.home.activation ? initializeNotificationForwardingTopic;
  assert enabledNotificationForwarding.config.home.activation ? reconcileNotificationForwardingHerdrPlugin;
  assert enabledNotificationForwarding.config.systemd.user.services.notification-forwarding.Service.Type == "notify";
  assert !overriddenDevelopment.config.programs.nixvim.opts.number;
  assert !overriddenTerminal.config.programs.fish.enable;
    pkgs.runCommand "module-contracts" {} ''
      ${notificationActivation}
      first_topic="$(< ${notificationTopicFile})"
      [[ "$first_topic" =~ ^[0-9a-f]{64}$ ]]
      [[ "$(stat -c '%a' ${notificationTopicDirectory})" == 700 ]]
      [[ "$(stat -c '%a' ${notificationTopicFile})" == 600 ]]

      ${notificationActivation}
      [[ "$(< ${notificationTopicFile})" == "$first_topic" ]]

      handler="$(${lib.getExe pkgs.python3} -c 'import sys, tomllib; print(tomllib.load(open(sys.argv[1], "rb"))["events"][0]["command"][0])' ${notificationHerdrPlugin}/herdr-plugin.toml)"
      state_dir="$TMPDIR/plugin-state"
      notifications="$TMPDIR/notifications"
      fake_systemctl=${notificationFakeSystemctl}
      fake_notify=${notificationFakeNotify}

      run_event() {
        status="$1"
        LOCKED="''${2:-0}" \
        NOTIFICATIONS="$notifications" \
        HERDR_PLUGIN_STATE_DIR="$state_dir" \
        HERDR_PLUGIN_CONTEXT_JSON='{"workspace_label":"nix","tab_label":"agent"}' \
        HERDR_PLUGIN_EVENT_JSON="$(${lib.getExe pkgs.jq} -nc --arg status "$status" '{data: {type: "pane_agent_status_changed", pane_id: "w1:p1", workspace_id: "w1", agent: "pi", agent_status: $status}}')" \
          "$handler" "$fake_systemctl" "$fake_notify"
      }

      run_event idle 1
      [[ ! -e "$notifications" ]]
      run_event working 0
      run_event idle 0
      [[ ! -e "$notifications" ]]
      run_event working 0
      run_event idle 1
      [[ "$(wc -l < "$notifications")" == 1 ]]
      grep -q 'pi finished.*nix · agent' "$notifications"
      run_event idle 1
      [[ "$(wc -l < "$notifications")" == 1 ]]
      run_event working 0
      run_event done 1
      run_event idle 1
      [[ "$(wc -l < "$notifications")" == 1 ]]
      run_event blocked 1
      run_event idle 1
      [[ "$(wc -l < "$notifications")" == 2 ]]
      run_event unknown 1
      run_event idle 1
      [[ "$(wc -l < "$notifications")" == 3 ]]

      run_event working 0
      LOCKED=1 \
      NOTIFICATIONS="$notifications" \
      HERDR_PLUGIN_STATE_DIR="$state_dir" \
      HERDR_PLUGIN_CONTEXT_JSON='{"workspace_label":"nix","tab_label":"agent"}' \
      HERDR_PLUGIN_EVENT_JSON='{"data":{"type":"pane_agent_status_changed","pane_id":"w1:p1","workspace_id":"w1","agent":"claude","agent_status":"idle"}}' \
        "$handler" "$fake_systemctl" "$fake_notify"
      [[ "$(wc -l < "$notifications")" == 3 ]]

      touch "$out"
    ''
