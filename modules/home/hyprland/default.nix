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
        bind = [
          "$appLauncher, B, exec, vivaldi"
          "$appLauncher, D, exec, vesktop"
          "$appLauncher, T, exec, kitty"
          "$appLauncher, S, exec, steam"
        ];
        bindm = [
          "$mod, mouse:272, moveWindow"
          "$mod, mouse:273, resizeWindow"
        ];
      };
    };
  };
}
