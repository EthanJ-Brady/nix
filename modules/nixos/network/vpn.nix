{
  config,
  lib,
  ...
}: {
  options = {
    custom.network.vpn.enable = lib.mkEnableOption "Enables the software and configuration needed for personal VPN connection via Tailscale";
  };

  config = lib.mkIf config.custom.network.vpn.enable {
    services.tailscale.enable = true;
  };
}
