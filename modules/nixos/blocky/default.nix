{
  config,
  lib,
  ...
}: let
  blocklists = import ./blocklists.nix;
in {
  options = {
    blocky.enable = lib.mkEnableOption "Enable blocky";
  };

  config = lib.mkIf config.blocky.enable {
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
          denylists = blocklists;
          clientGroupsBlock = {
            default = ["ads"];
          };
        };
      };
    };
    networking.firewall.allowedTCPPorts = [53];
    networking.firewall.allowedUDPPorts = [53];
  };
}
