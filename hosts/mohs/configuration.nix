{pkgs, ...}: {
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53;
      upstreams.groups.default = [
        "https://one.one.one.one/dns-query"
      ];
      bootstrapDns = {
        upstream = "https://one.one.one.one/dns-query";
        ips = ["1.1.1.1" "1.0.0.1"];
      };
      blocking = {
        denylists = {
          ads = [
            "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
            "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
            "https://v.firebog.net/hosts/static/w3kbl.txt"
            "https://adaway.org/hosts.txt"
            "https://v.firebog.net/hosts/AdguardDNS.txt"
            "https://v.firebog.net/hosts/Admiral.txt"
            "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
            "https://v.firebog.net/hosts/Easylist.txt"
            "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
            "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"
            "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
            "https://v.firebog.net/hosts/Easyprivacy.txt"
            "https://v.firebog.net/hosts/Prigent-Ads.txt"
            "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"
            "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
            "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
            "https://v.firebog.net/hosts/Prigent-Crypto.txt"
            "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"
            "https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt"
            "https://phishing.army/download/phishing_army_blocklist_extended.txt"
            "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
            "https://v.firebog.net/hosts/RPiList-Malware.txt"
            "https://v.firebog.net/hosts/RPiList-Phishing.txt"
            "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
            "https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts"
            "https://urlhaus.abuse.ch/downloads/hostfile/"
            "https://lists.cyberhost.uk/malware.txt"
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          ];
          adult = ["https://blocklistproject.github.io/Lists/porn.txt"];
        };
        clientGroupsBlock = {
          default = ["ads"];
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [53];
  networking.firewall.allowedUDPPorts = [53];

  ssh = {
    enable = true;
    username = "mohs";
  };

  programs.zsh.enable = true;

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
    packages = [];
    shell = pkgs.zsh;
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
