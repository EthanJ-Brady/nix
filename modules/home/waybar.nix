{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    waybar.enable = lib.mkEnableOption "Enables waybar";
  };

  config = lib.mkIf config.waybar.enable {
    programs.waybar.enable = true;

    home.packages = with pkgs; [
      pulsemixer
    ];

    wayland.windowManager.hyprland.settings = lib.mkIf config.hyprland.enable {
      "exec-once" = ["waybar"];
    };
  };
}
