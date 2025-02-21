{pkgs, ...}: {
  custom = {
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      laptop.enable = true;
      nvidia.enable = true;
      peripherals.enable = true;
    };
  };

  bootloader.enable = true;
  hyprland.enable = true;
  gaming.enable = true;
  ssh = {
    enable = true;
    username = "ethan";
  };

  security.sudo.wheelNeedsPassword = false;

  networking.hostName = "bernoulli";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  programs.zsh.enable = true;

  services.openssh.enable = true;

  users.users.ethan = {
    isNormalUser = true;
    description = "Ethan Brady";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  virtualisation.docker.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ethan";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.system = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    wl-clipboard
    nodejs_23
    ripgrep
    fd
    cargo
    gparted
    brave
    ghostty
  ];

  environment.sessionVariables.FLAKE = "/home/ethan/Dotfiles/nix";

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  fileSystems."/run/media/ethan/Games" = {
    device = "/dev/nvme0n1p6";
  };

  system.stateVersion = "23.11";
}
