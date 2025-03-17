{
  config,
  lib,
  ...
}: {
  options = {
    custom.tofi.enable = lib.mkEnableOption "Enables the wofi application launcher";
  };

  config = lib.mkIf config.custom.tofi.enable {
    programs.tofi = {
      enable = true;
      settings = {
        width = 720;
        height = 540;
      };
    };

    home.file = {
      ".config/tofi/nerdfont.txt".source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/8bitmcu/NerdFont-Cheat-Sheet/main/nerdfont.txt";
        sha256 = "sha256:18rzlify5g7naqqryzkvnsh7c0y8drmqa8x83mra7mxy229a81bn";
      };
    };

    wayland.windowManager.hyprland.settings.bind = lib.mkIf config.hyprland.enable [
      "SUPER, space, exec, tofi-drun --drun-launch=true"
      "SUPER, V, exec, cliphist list | tofi --fuzzy-match=true | cliphist decode | wl-copy"
      "SUPER, E, exec, sort ~/.config/tofi/nerdfont.txt | awk '{printf \"%s  %s\\n\", $1, $4}' | tofi --fuzzy-match=true | awk '{printf \"%s\", $1}' | wl-copy"
    ];
  };
}
