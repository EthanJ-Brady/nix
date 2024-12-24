{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.gnome.enable {
    home.packages = with pkgs; [ gnomeExtensions.quick-settings-tweaker ];

    dconf.settings = {
      "org/gnome/shell".enabled-extensions = [
        "quick-settings-tweaks@qwreey"
      ];
    };
  };
}
