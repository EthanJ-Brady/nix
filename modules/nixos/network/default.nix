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
    custom.network.enable = lib.mkEnableOption "Enables network related configurations including ssh and vpn";
  };

  config = lib.mkIf config.custom.network.enable {
    custom.network.ssh.enable = lib.mkDefault true;
    custom.network.vpn.enable = lib.mkDefault true;
  };
}
