{
  config,
  lib,
  ...
}: let
  domain = "ethanbrady.xyz";
  headscaleSubdomain = "vpn";
  headscalePort = 8080;
in {
  options = {
    custom.cloud.headscale.enable = lib.mkEnableOption "Enables a headscale server";
  };

  config = lib.mkIf config.custom.cloud.headscale.enable {
    services.headscale = {
      enable = true;
      address = "0.0.0.0";
      port = headscalePort;
      settings = {
        server_url = "https://${headscaleSubdomain}.${domain}";
      };
      settings.dns = {
        magic_dns = true;
        base_domain = "tailnet.${domain}";
      };
    };

    services.caddy = {
      enable = true;
      virtualHosts."${headscaleSubdomain}.${domain}" = {
        extraConfig = ''
          reverse_proxy * 127.0.0.1:${toString headscalePort}
        '';
      };
    };

    networking.firewall.allowedTCPPorts = [443];
    networking.firewall.allowedUDPPorts = [443];
  };
}
