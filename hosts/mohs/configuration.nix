{
  pkgs,
  ...
}:
{

  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # SSH
  services.openssh.enable = true;
  services.openssh.extraConfig = ''
    PubkeyAuthentication yes
  '';

  # Experimental features
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  # Networking
  networking.hostName = "mohs";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define user account
  users.users.mohs = {
    isNormalUser = true;
    description = "mohs";
    extraGroups = [
      "networkmanager"
      "wheel"
      "minecraft"
    ];
    packages = [ ];
  };

  users.users.minecraft = {
    shell = "${pkgs.bash}/bin/bash";
  };

  # Enable automatic login for the user
  services.getty.autologinUser = "mohs";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

    jvmOpts = "-Xmx12000M -Xms12000M -XX:+UseG1GC";
  };

  # systemd.services.mc-git-auto-commit = {
  #   description = "Automatically commit changes to the Minecraft server";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     WorkingDirectory = "/var/lib/vanilla";
  #     ExecStart = [
  #       "${pkgs.git}/bin/git add -A"
  #       "${pkgs.git}/bin/git commit -m 'Automatic weekly commit'"
  #       "${pkgs.git}/bin/git push origin main"
  #     ];
  #   };
  # };

  # systemd.timers.mc-git-auto-commit = {
  #   description = "Run mc git auto commit weekly";
  #   timerConfig.OnCalendar = "weekly";
  #   timerConfig.Persistent = true;
  #   wantedBy = [ "timers.target" ];
  # };

  systemd.services.ssh-tunnel = {
    enable = true;
    description = "SSH tunnel for the minecraft server";
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.autossh}/bin/autossh -M 0 -N -o ExitOnForwardFailure=yes -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -R 25565:localhost:25565 morse";
      Restart = "always";
      RestartSec = "10s";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
