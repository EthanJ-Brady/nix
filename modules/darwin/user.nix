{
  config,
  lib,
  ...
}: {
  options = {
    custom.user.enable = lib.mkEnableOption "Setups the user account for the system";
    custom.user.username = lib.mkOption {
      type = lib.types.str;
      default = "ethanbrady";
      description = "The username for the user account";
    };
  };

  config = lib.mkIf config.custom.user.enable {
    users.users."${config.custom.user.username}".home = "/Users/${config.custom.user.username}";
  };
}
