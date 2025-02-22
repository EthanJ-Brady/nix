{pkgs, ...}: {
  custom = {
    desktop.enable = true;
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      laptop.enable = true;
      nvidia.enable = true;
      peripherals.enable = true;
    };
  };

  bootloader.enable = true;
  gaming.enable = true;
  ssh = {
    enable = true;
    username = "ethan";
  };

  security.sudo.wheelNeedsPassword = false;

  networking.networkmanager.enable = true;

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

  environment.systemPackages = with pkgs; [
    nodejs_23
    ripgrep
    fd
    cargo
    gparted
    brave
    ghostty
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  fileSystems."/run/media/ethan/Games" = {
    device = "/dev/nvme0n1p6";
  };

  networking.hostName = "bernoulli";
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.system = "x86_64-linux";
  system.stateVersion = "23.11";
}
