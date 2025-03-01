{
  config,
  lib,
  ...
}: {
  options = {
    custom.cloud.headscale.enable = lib.mkEnableOption "Enables a headscale server";
  };

  config = lib.mkIf config.custom.cloud.headscale.enable {
    services.headscale = {
      enable = true;
      address = "0.0.0.0";
      settings.dns.magic_dns = false;
      settings.server_url = "http://ethanbrady.xyz:8080";
    };
    networking.firewall.allowedTCPPorts = [443 8080];
    networking.firewall.allowedUDPPorts = [443 8080];
  };
}
