{ pkgs, builtins, ... }:
{
  services.openssh.enable = true;
  services.openssh.extraConfig = ''
    PubkeyAuthentication yes
  '';

  services.minecraft = {
    enable = true;
    eula = true;
    declarative = true;
    package = pkgs.minecraft-server;
    dataDir = "/var/lib/vanilla";

    serverProperties = {
      gamemode = "survival";
      difficulty = "hard";
      simulation-distance = 8;
      enforce-whitelist = true;
      max-players = 8;
      motd = "Welcome to NixOS Minecraft Server!";
      view-distance = 8;
      white-list = true;
    };

    whitelist = {
      Bowchick = "3d7a826b-60a8-4e7a-a668-2a15be34f7f1";
      EJVantaFire = "96e6b0cb-35ec-4f1a-a2e2-bcb14d2511fd";
      ElPlays = "ac8792ad-413e-4186-895d-4c7f01fff997";
      Moochew = "173f2715-6f0d-47f0-97d3-c8c15b4c23aa";
      Pleiades44 = "c96f94d3-65dd-4c1d-bb46-c4aa76acd63e";
      SagittaRaptor = "574dce0f-584e-4a33-b8a3-2f91b0cc2e90";
      TheCandyScount = "b77266ec-df85-45ef-9bbd-f3fcd88c3322";
      Webhead1202 = "e1b22812-0efc-438b-8209-f32230f34dfc";
    };

    jvmOpts = "-Xmx12000M -Xms12000M -XX: +UseG1GC";
  };

  systemd.services.mc-git-auto-commit = {
    description = "Automatically commit changes to the Minecraft server";
    serviceConfig = {
      Type = "oneshot";
      WorkingDirectory = "/var/lib/vanilla";
      ExecStart = [
        "${pkgs.git}/bin/git add -A"
        "${pkgs.git}/bin/git commit -m 'Automatic weekly commit'"
        "${pkgs.git}/bin/git push origin main"
      ];
    };
  };

  systemd.timers.mc-git-auto-commit = {
    description = "Run mc git auto commit weekly";
    timerConfig.OnCalendar = "weekly";
    timerConfig.Persistent = true;
    wantedBy = [ "timers.target" ];
  };

  systemd.services.autossh-minecraft = {
    description = "AutoSSH Reverse Tunnel for Minecraft Server";
    after = [ "network.target" ];

    serviceConfig = {
      EnvironmentFile = "/etc/autossh.env";
      ExecStart = "${pkgs.autossh}/bin/ssh -NT -o ServerAliveInterval=60 -L 25565:localhost:25565 ${builtins.getEnv "AUTOSSH_REMOTE_HOST"}";
      Restart = "always";
      RestartSec = "10s";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
