{
  config,
  lib,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./wayland.nix
  ];

  options = {
    custom.desktop.enable = lib.mkEnableOption "Enables a window manager for the system";
  };

  config = lib.mkIf config.custom.desktop.enable {
    custom.desktop.hyprland.enable = true;
    custom.desktop.wayland.enable = true;
  };
}
