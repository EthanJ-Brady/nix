{
  config,
  lib,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkEnableOption "Enables the hyprland window tiling manager and it's associated config";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
