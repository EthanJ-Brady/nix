{...}: {
  custom = {
    enable = true;
    bootloader.enable = true;
    desktop.enable = true;
    docker.enable = true;
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      laptop.enable = true;
      nvidia.enable = true;
      peripherals.enable = true;
    };
    obs.enable = true;
    ssh.enable = true;
    user.enable = true;
  };

  gaming.enable = true;

  fileSystems."/run/media/ethan/Games" = {
    device = "/dev/nvme0n1p6";
  };

  networking.hostName = "bernoulli";
  nixpkgs.system = "x86_64-linux";
  system.stateVersion = "23.11";
}
