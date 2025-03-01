{pkgs, ...}: {
  custom = {
    enable = true;
    bootloader.enable = true;
    homelab.enable = true;
    user = {
      enable = false;
      username = "mohs";
    };
  };

  programs.zsh.enable = true;

  # Networking
  networking.hostName = "mohs";

  # Define user account
  users.users.mohs = {
    isNormalUser = true;
    description = "mohs";
    extraGroups = [
      "networkmanager"
      "wheel"
      "minecraft"
    ];
    packages = [];
    shell = pkgs.zsh;
  };

  users.users.minecraft = {
    shell = "${pkgs.bash}/bin/bash";
  };

  # Enable automatic login for the user
  services.getty.autologinUser = "mohs";

  # Packages
  environment.systemPackages = with pkgs; [
    vim
    git
    autossh
  ];

  # State version
  system.stateVersion = "24.05";

  # Minecraft Server
  services.minecraft-server = {
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

    jvmOpts = "-Xms10240M -Xmx10240M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20";
  };

  systemd.services.ssh-tunnel = {
    enable = true;
    description = "SSH tunnel for the minecraft server";
    after = ["network.target"];

    serviceConfig = {
      ExecStart = "${pkgs.autossh}/bin/autossh -M 0 -N -o ExitOnForwardFailure=yes -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -R 25565:localhost:25565 morse";
      Restart = "always";
      RestartSec = "10s";
    };

    wantedBy = ["multi-user.target"];
  };
}
