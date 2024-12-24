{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.gnome.enable {
    home.packages = with pkgs; [ gnomeExtensions.forge ];

    dconf.settings = {
      "org/gnome/shell".enabled-extensions = [
        "forge@jmmaranan.com"
      ];

      "org/gnome/shell/extensions/forge" = {
        "window-gap-size" = "uint32 8";
        "window-gap-size-increment" = "uint32 2";
      };

      "org/gnome/shell/extensions/forge/keybindings" = {
        "window-focus-down" = [ "<Alt>Down" ];
        "window-focus-up" = [ "<Alt>Up" ];
        "window-focus-left" = [ "<Alt>Left" ];
        "window-focus-right" = [ "<Alt>Right" ];
        "window-move-down" = [ "<Alt><Shift>Down" ];
        "window-move-up" = [ "<Alt><Shift>Up" ];
        "window-move-left" = [ "<Alt><Shift>Left" ];
        "window-move-right" = [ "<Alt><Shift>Right" ];
        "window-toggle-float" = [ "<Alt>c" ];
      };
    };
  };
}
