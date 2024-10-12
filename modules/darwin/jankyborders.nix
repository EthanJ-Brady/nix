{ config, lib, ... }:
{
  options = {
    jankyborders.enable = lib.mkEnableOption "Enables jankyborders, a simple window highlighting tool.";
  };

  config = {
    jankyborders.enable = lib.mkDefault true;

    services.jankyborders = lib.mkIf config.jankyborders.enable {
      enable = true;
      active_color = "0xffc37779";
      inactive_color = "0xff80abe3";
      width = 7.5;
    };
  };
}
