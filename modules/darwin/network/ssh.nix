{
  config,
  lib,
  ...
}: let
  keyDir = ../../../static/ssh;
  keyFiles = builtins.attrNames (builtins.readDir keyDir);
in {
  options = {
    custom.network.ssh.enable = lib.mkEnableOption "Enables the ssh configuration for darwin";
  };

  config = lib.mkIf config.custom.network.ssh.enable {
    services.openssh.enable = true;
    users.users."${config.custom.user.username}".openssh.authorizedKeys.keyFiles =
      map (
        file: "${keyDir}/${file}"
      )
      keyFiles;
  };
}
