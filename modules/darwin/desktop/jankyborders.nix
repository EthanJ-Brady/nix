{
  config,
  lib,
  ...
}: {
  options = {
    custom.desktop.jankyborders.enable = lib.mkEnableOption "Enables jankyborders, a simple window highlighting tool.";
  };

  config = lib.mkIf config.custom.desktop.jankyborders.enable {
    services.jankyborders = {
      enable = true;
      active_color = "0xffbabbf1";
      inactive_color = "0xff737994";
      width = 8.0;
    };
  };
}
