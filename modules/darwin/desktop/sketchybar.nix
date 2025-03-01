{
  config,
  lib,
  ...
}: {
  options = {
    custom.desktop.sketchybar.enable = lib.mkEnableOption "Enables sketchybar, a custom status bar for MacOS";
  };

  config = lib.mkIf config.custom.desktop.sketchybar.enable {
    services.sketchybar = {
      enable = true;
    };
  };
}
