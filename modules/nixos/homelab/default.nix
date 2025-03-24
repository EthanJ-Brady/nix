{
  config,
  lib,
  ...
}: {
  imports = [
    ./blocky
    ./nextcloud.nix
    ./tandoor.nix
  ];

  options = {
    custom.homelab.enable = lib.mkEnableOption "Enable homelab";
  };

  config = lib.mkIf config.custom.homelab.enable {
    custom.homelab.blocky.enable = lib.mkDefault true;
    custom.homelab.nextcloud.enable = lib.mkDefault true;
    custom.homelab.tandoor.enable = lib.mkDefault true;
  };
}
