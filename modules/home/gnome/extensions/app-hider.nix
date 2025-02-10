{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.gnome.enable {
    home.packages = with pkgs; [gnomeExtensions.app-hider];

    dconf.settings = {
      "org/gnome/shell".enabled-extensions = [
        "app-hider@lynith.dev"
      ];

      "org/gnome/shell/extensions/app-hider" = {
        "hidden-apps" = [
          "cups.desktop"
          "nixos-manual.desktop"
          "nvim.desktop"
        ];
      };
    };
  };
}
