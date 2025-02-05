{
  config,
  lib,
  ...
}:
{
  options = {
    waybar.enable = lib.mkEnableOption "Enables waybar";
  };

  config = lib.mkIf config.waybar.enable {
    programs.waybar.enable = true;

    wayland.windowManager.hyprland.settings = lib.mkIf config.hyprland.enable {
      "exec-once" = [ "waybar" ];
    };
  };
}
