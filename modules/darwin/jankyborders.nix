{ config, lib, ... }:
{
  options = {
    jankyborders.enable = lib.mkEnableOption "Enables jankyborders, a simple window highlighting tool.";
  };

  config = lib.mkIf config.jankyborders.enable {
    services.jankyborders = {
      enable = true;
      active_color = "0xffe78284";
      inactive_color = "0xff8caaee";
      width = 7.5;
    };
  };
}
