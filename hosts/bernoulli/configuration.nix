{pkgs, ...}: {
  custom = {
    enable = true;
    bootloader.enable = true;
    desktop.enable = true;
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      laptop.enable = true;
      nvidia.enable = true;
      peripherals.enable = true;
    };
    user.enable = true;
  };

  gaming.enable = true;
  ssh = {
    enable = true;
    username = "ethan";
  };

  virtualisation.docker.enable = true;

  fileSystems."/run/media/ethan/Games" = {
    device = "/dev/nvme0n1p6";
  };

  networking.hostName = "bernoulli";
  nixpkgs.system = "x86_64-linux";
  system.stateVersion = "23.11";
}
