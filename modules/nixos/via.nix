{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    via.enable = lib.mkEnableOption "Enables via, a graphical UI for interacting with QMK keyboards";
  };

  config = lib.mkIf config.via.enable {
    environment.systemPackages = with pkgs; [
      via
    ];
    services.udev.packages = with pkgs; [ via ];
  };
}
