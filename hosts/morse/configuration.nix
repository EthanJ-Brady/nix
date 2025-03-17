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

  networking.firewall.allowedTCPPorts = [25565];
  networking.firewall.allowedUDPPorts = [25565];
  services.openssh.settings.GatewayPorts = "yes";

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "morse";
  networking.domain = "";
  system.stateVersion = "23.11";
}
