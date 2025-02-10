{
  config,
  lib,
  ...
}: {
  options = {
    locale.timezone = lib.mkOption {
      type = lib.types.str;
      default = "America/Denver";
      description = "The time zone to use for the system";
    };
    locale.identifier = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "The locale identifier to use for locale settings";
    };
  };

  config = {
    time.timeZone = config.locale.timezone;
    i18n.defaultLocale = config.locale.identifier;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = config.locale.identifier;
      LC_IDENTIFICATION = config.locale.identifier;
      LC_MEASUREMENT = config.locale.identifier;
      LC_MONETARY = config.locale.identifier;
      LC_NAME = config.locale.identifier;
      LC_NUMERIC = config.locale.identifier;
      LC_PAPER = config.locale.identifier;
      LC_TELEPHONE = config.locale.identifier;
      LC_TIME = config.locale.identifier;
    };
  };
}
