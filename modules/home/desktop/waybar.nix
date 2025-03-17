{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    custom.desktop.waybar.enable = lib.mkEnableOption "Enables waybar";
  };

  config = lib.mkIf config.custom.desktop.waybar.enable {
    programs.waybar.enable = true;

    home.packages = with pkgs; [
      pulsemixer
    ];

    wayland.windowManager.hyprland.settings = lib.mkIf config.custom.desktop.hyprland.enable {
      "exec-once" = ["waybar"];
    };
  };
}
