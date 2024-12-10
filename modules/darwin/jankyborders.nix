{ config, lib, ... }:
{
  options = {
    jankyborders.enable = lib.mkEnableOption "Enables jankyborders, a simple window highlighting tool.";
  };

  config = {
    jankyborders.enable = lib.mkDefault true;

    services.jankyborders = lib.mkIf config.jankyborders.enable {
      enable = true;
      active_color = "0xffe78284";
      inactive_color = "0xff8caaee";
      width = 7.5;
    };
  };
}
