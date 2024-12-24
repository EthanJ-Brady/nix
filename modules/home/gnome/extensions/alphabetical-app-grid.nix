{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.gnome.enable {
    home.packages = with pkgs; [ gnomeExtensions.alphabetical-app-grid ];

    dconf.settings = {
      "org/gnome/shell".enabled-extensions = [
        "AlphabeticalAppGrid@stuarthayhurst"
      ];
    };
  };
}
