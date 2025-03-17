{
  config,
  lib,
  ...
}: {
  options = {
    custom.desktop.sunshine.enable = lib.mkEnableOption "Enables sunshine, a stream host for Moonlight";
  };

  config = lib.mkIf config.custom.desktop.sunshine.enable {
    services.sunshine = {
      enable = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
