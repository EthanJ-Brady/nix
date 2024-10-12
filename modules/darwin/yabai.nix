{ config, lib, ... }:
{
  options = {
    yabai.enable = lib.mkEnableOption "Enables yabai, a tiling window manager for macOS.";
  };

  config = {
    yabai.enable = lib.mkDefault true;

    services.yabai = lib.mkIf config.yabai.enable {
      enable = true;
    };
  };
}
