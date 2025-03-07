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
          hostname = "bernoulli.tailnet.ethanbrady.xyz";
          user = "ethan";
        };
        newton = lib.mkDefault {
          host = "newton";
          hostname = "newton.tailnet.ethanbrady.xyz";
          user = "ethanbrady";
        };
        morse = lib.mkDefault {
          host = "morse";
          hostname = "ethanbrady.xyz";
          user = "ethan";
        };
        mohs = lib.mkDefault {
          host = "mohs";
          hostname = "mohs.tailnet.ethanbrady.xyz";
          user = "mohs";
        };
      };
    };
  };
}
