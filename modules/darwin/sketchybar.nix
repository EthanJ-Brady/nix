{ config, lib, ... }:
{
  options = {
    sketchybar.enable = lib.mkEnableOption "Enables sketchybar, a custom status bar for MacOS";
  };

  config = lib.mkIf config.sketchybar.enable {
    services.sketchybar = {
      enable = true;
    };
  };
}
