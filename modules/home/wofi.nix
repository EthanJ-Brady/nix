{
  config,
  lib,
  ...
}: {
  options = {
    wofi.enable = lib.mkEnableOption "Enables the wofi application launcher";
  };

  config = lib.mkIf config.wofi.enable {
    programs.wofi = {
      enable = true;
    };

    home.file = {
      ".config/wofi/nerdfont.txt".source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/8bitmcu/NerdFont-Cheat-Sheet/main/nerdfont.txt";
        sha256 = "sha256:18rzlify5g7naqqryzkvnsh7c0y8drmqa8x83mra7mxy229a81bn";
      };
    };

    wayland.windowManager.hyprland.settings.bind = lib.mkIf config.hyprland.enable [
      "SUPER, space, exec, wofi --show drun"
      "SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
      "SUPER, E, exec, cat ~/.config/wofi/nerdfont.txt | awk '{print $1, $4}' | wofi --dmenu | awk '{printf \"%s\", $1}' | wl-copy"
    ];
  };
}
