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
    custom.network.ssh.username = lib.mkOption {
      default = "ethanbrady";
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.custom.network.ssh.enable {
    services.openssh.enable = true;
    users.users."${config.custom.network.ssh.username}".openssh.authorizedKeys.keyFiles =
      map (
        file: "${keyDir}/${file}"
      )
      keyFiles;
  };
}
