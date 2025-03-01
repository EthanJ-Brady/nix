{
  config,
  lib,
  ...
}: {
  options = {
    custom.homelab.tandoor.enable = lib.mkEnableOption "Enables tandoor recipes";
  };

  config = lib.mkIf config.custom.homelab.tandoor.enable {
    services.tandoor-recipes = {
      enable = true;
      port = 8081;
      address = "0.0.0.0";
    };
    networking.firewall.allowedTCPPorts = [8081];
    networking.firewall.allowedUDPPorts = [8081];
  };
}
