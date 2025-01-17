{ config, lib, ... }:
{
  options = {
    ssh.enable = lib.mkEnableOption "Enables ssh and automatically generates ed25519 keys if they don't exist";
  };

  config = lib.mkIf config.ssh.enable {
    home.activation.generateSSHKey = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -f ${config.home.homeDirectory}/.ssh/id_ed25519 ]; then
        ssh-keygen -t ed25519 -f ${config.home.homeDirectory}/.ssh/id_ed25519 -N ""
      fi
    '';
  };
}
