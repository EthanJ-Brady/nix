{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    bananaCursor.enable = lib.mkEnableOption "Enables the banana cursor";
  };

  config = lib.mkIf config.bananaCursor.enable {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Banana";
      package = pkgs.banana-cursor;
      size = 24;
    };

    wayland.windowManager.hyprland.settings = {
      env = [
        "HYPRCURSOR_THEME,banana"
        "HYPRCURSOR_SIZE,24"
      ];
    };
  };
}
