{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.gnome.enable {
    home.packages = with pkgs; [ gnomeExtensions.blur-my-shell ];

    dconf.settings = {
      "org/gnome/shell".enabled-extensions = [
        "blur-my-shell@aunetx"
      ];

      "org/gnome/shell/extensions/blur-my-shell" = {
        "brightness" = 1.0;
        "sigma" = "30";
      };

      "org/gnome/shell/extensions/blur-my-shell/panel".blur = false;

      "org/gnome/shell/extensions/blur-my-shell/applications" = {
        "blur" = true;
        "opacity" = "230";
        "whitelist" = [
          "kitty"
        ];
      };
    };
  };
}
