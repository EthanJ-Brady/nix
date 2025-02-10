{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.gnome.enable {
    home.packages = with pkgs; [gnomeExtensions.unite];

    dconf.settings = {
      "org/gnome/shell".enabled-extensions = [
        "unite@hardpixel.eu"
      ];

      "org/gnome/shell/extensions/unite" = {
        "app-menu-ellipsize-mode" = "start";
        "autofocus-windows" = false;
        "enable-titlebar-actions" = false;
        "extend-left-box" = false;
        "greyscale-tray-icons" = false;
        "hide-activities-button" = "never";
        "hide-app-menu-icon" = false;
        "hide-window-titlebars" = "always";
        "notifications-position" = "center";
        "reduce-panel-spacing" = false;
        "restrict-to-primary-screen" = false;
        "show-appmenu-button" = true;
        "show-desktop-name" = false;
        "show-legacy-tray" = false;
        "show-window-buttons" = "never";
        "show-window-title" = "never";
        "use-activities-text" = false;
      };
    };
  };
}
