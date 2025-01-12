{
  config,
  lib,
  ...
}:
{
  options = {
    hyprland.enable =  lib.mkEnableOption "Enables hyprland user configuration";
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$appLauncher" = "ALT_SHIFT_CTRL";
        "$mod" = "ALT";
        "$mod_alt" = "ALT_SHIFT";
        bind = [
          "$appLauncher, B, exec, vivaldi"
          "$appLauncher, D, exec, vesktop"
          "$appLauncher, T, exec, kitty"
          "$appLauncher, S, exec, steam"
          "SUPER, Q, killactive"
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "$mod_alt, left, movewindow, l"
          "$mod_alt, right, movewindow, r"
          "$mod_alt, up, movewindow, u"
          "$mod_alt, down, movewindow, d"
        ];
        bindm = [
          "$mod, mouse:272, moveWindow"
          "$mod, mouse:273, resizeWindow"
        ];
      };
    };
  };
}
