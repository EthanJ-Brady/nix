{
  config,
  lib,
  ...
}: {
  imports = [
    ./blocky
    ./tandoor.nix
  ];

  options = {
    custom.homelab.enable = lib.mkEnableOption "Enable homelab";
  };

  config = lib.mkIf config.custom.homelab.enable {
    custom.homelab.blocky.enable = lib.mkDefault true;
    custom.homelab.tandoor.enable = lib.mkDefault true;
  };
}
