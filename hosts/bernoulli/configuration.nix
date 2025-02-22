{pkgs, ...}: {
  custom = {
    enable = true;
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

  programs.zsh.enable = true;

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
  nixpkgs.system = "x86_64-linux";
  system.stateVersion = "23.11";
}
