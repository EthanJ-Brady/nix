{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.gnome.enable {
    home.packages = with pkgs; [gnomeExtensions.quick-settings-audio-devices-renamer];

    dconf.settings = {
      "org/gnome/shell".enabled-extensions = [
        "quicksettings-audio-devices-renamer@marcinjahn.com"
      ];
    };
  };
}
