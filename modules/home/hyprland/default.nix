{
  config,
  lib,
  ...
}:
{
  options = {
    hyprland.enable =  lib.mkEnableOption "Enables hyprland user configuration";
  };

  config = lib.mkIf config.hyprland.enable {};
}
