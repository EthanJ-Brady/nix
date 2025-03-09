{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    custom.desktop.bananaCursor.enable = lib.mkEnableOption "Enables the banana cursor";
  };

  config = lib.mkIf config.custom.desktop.bananaCursor.enable {
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
