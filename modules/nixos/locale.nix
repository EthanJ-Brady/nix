{
  config,
  lib,
  ...
}: {
  options = {
    custom.locale.enable = lib.mkEnableOption "Enables locale settings for the system";
    custom.locale.timezone = lib.mkOption {
      type = lib.types.str;
      default = "America/Denver";
      description = "The time zone to use for the system";
    };
    custom.locale.identifier = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "The locale identifier to use for locale settings";
    };
  };

  config = lib.mkIf config.custom.locale.enable {
    time.timeZone = config.custom.locale.timezone;
    i18n.defaultLocale = config.custom.locale.identifier;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = config.custom.locale.identifier;
      LC_IDENTIFICATION = config.custom.locale.identifier;
      LC_MEASUREMENT = config.custom.locale.identifier;
      LC_MONETARY = config.custom.locale.identifier;
      LC_NAME = config.custom.locale.identifier;
      LC_NUMERIC = config.custom.locale.identifier;
      LC_PAPER = config.custom.locale.identifier;
      LC_TELEPHONE = config.custom.locale.identifier;
      LC_TIME = config.custom.locale.identifier;
    };
  };
}
