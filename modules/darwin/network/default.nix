{
  config,
  lib,
  ...
}: {
  imports = [
    ./ssh.nix
    ./vpn.nix
  ];

  options = {
    custom.network.enable = lib.mkEnableOption "Enables the network configuration for darwin";
  };

  config = lib.mkIf config.custom.network.enable {
    custom.network.ssh.enable = lib.mkDefault true;
    custom.network.vpn.enable = lib.mkDefault true;
  };
}
