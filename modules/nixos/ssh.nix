{
  config,
  lib,
  ...
}: let
  keyDir = ../../static/ssh;
  keyFiles = builtins.attrNames (builtins.readDir keyDir);
in {
  options = {
    custom.ssh.enable = lib.mkEnableOption "Enables the ssh configuration for linux";
  };

  config = lib.mkIf config.custom.ssh.enable {
    services.openssh.enable = true;
    users.users = lib.mkIf config.custom.user.enable {
      "${config.custom.user.username}".openssh.authorizedKeys.keyFiles =
        map (
          file: "${keyDir}/${file}"
        )
        keyFiles;
    };
  };
}
