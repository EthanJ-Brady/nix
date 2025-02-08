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

    programs.ssh = {
      enable = true;
      matchBlocks = {
        github = lib.mkDefault {
          host = "github";
          hostname = "github.com";
          user = "git";
        };
        gitlab = lib.mkDefault {
          host = "gitlab";
          hostname = "gitlab.cs.usu.edu";
          user = "git";
        };
        morse = lib.mkDefault {
          host = "morse";
          hostname = "45.79.71.62";
          user = "ethan";
        };
        mohs = lib.mkDefault {
          host = "mohs";
          hostname = "192.168.1.134";
          user = "mohs";
        };
      };
    };
  };
}
