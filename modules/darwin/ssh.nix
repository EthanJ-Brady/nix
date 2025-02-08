{
  config,
  lib,
  ...
}:
let
  keyDir = ../../static/ssh;
  keyFiles = builtins.attrNames (builtins.readDir keyDir);
in
{
  options = {
    ssh.enable = lib.mkEnableOption "Enables the ssh configuration for darwin";
    ssh.username = lib.mkOption {
      default = "default";
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.ssh.enable {
    services.openssh.enable = true;
    users.users."${config.ssh.username}".openssh.authorizedKeys.keyFiles = map (
      file: "${keyDir}/${file}"
    ) keyFiles;
  };
}
