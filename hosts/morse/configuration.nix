{...}: {
  imports = [
    ./networking.nix # generated at runtime by nixos-infect
  ];

  custom = {
    enable = true;
    cloud.headscale.enable = true;
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "morse";
  networking.domain = "";
  system.stateVersion = "23.11";
}
