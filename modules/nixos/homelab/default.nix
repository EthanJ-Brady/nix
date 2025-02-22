{
  config,
  lib,
  ...
}: {
  imports = [
    ./blocky
  ];

  options = {
    custom.homelab.enable = lib.mkEnableOption "Enable homelab";
  };

  config = lib.mkIf config.custom.homelab.enable {
    custom.homelab.blocky.enable = lib.mkDefault true;
  };
}
