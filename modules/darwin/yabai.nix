{ config, lib, ... }:
{
  options = {
    yabai.enable = lib.mkEnableOption "Enables yabai, a tiling window manager for macOS.";
  };

  config = lib.mkIf config.yabai.enable {
    services.yabai = {
      enable = true;
    };
  };
}
