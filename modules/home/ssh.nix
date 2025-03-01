{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    ssh.enable = lib.mkEnableOption "Enables ssh and automatically generates ed25519 keys if they don't exist";
  };

  config = lib.mkIf config.ssh.enable {
    home.activation.generateSSHKey = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ ! -f ${config.home.homeDirectory}/.ssh/id_ed25519 ]; then
        ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f ${config.home.homeDirectory}/.ssh/id_ed25519 -q -N ""
      fi
    '';

    programs.ssh = {
      enable = true;
      matchBlocks = {
        bernoulli = lib.mkDefault {
          host = "bernoulli";
          hostname = "100.64.0.5";
          user = "ethan";
        };
        newton = lib.mkDefault {
          host = "newton";
          hostname = "100.64.0.4";
          user = "ethanbrady";
        };
        morse = lib.mkDefault {
          host = "morse";
          hostname = "ethanbrady.xyz";
          user = "ethan";
        };
        mohs = lib.mkDefault {
          host = "mohs";
          hostname = "100.64.0.6";
          user = "mohs";
        };
      };
    };
  };
}
