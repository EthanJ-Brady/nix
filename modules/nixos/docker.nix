{
  config,
  lib,
  ...
}: {
  options = {
    custom.docker.enable = lib.mkEnableOption "Enables docker for the system";
  };

  config = lib.mkIf config.custom.docker.enable {
    virtualisation.docker.enable = true;
    users.users = lib.mkIf config.custom.user.enable {
      "${config.custom.user.username}".extraGroups = ["docker"];
    };
  };
}
