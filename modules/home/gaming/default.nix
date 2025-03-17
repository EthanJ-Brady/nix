{
  config,
  lib,
  ...
}: {
  imports = [
    ./games
    ./mangohud.nix
  ];

  options = {
    custom.gaming.enable = lib.mkEnableOption "Enables gaming specific settings for home manager";
  };

  config = lib.mkIf config.custom.gaming.enable {
    custom.gaming.mangohud.enable = lib.mkDefault true;
  };
}
