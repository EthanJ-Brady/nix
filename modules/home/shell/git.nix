{
  config,
  lib,
  ...
}: {
  options = {
    custom.shell.git.enable = lib.mkEnableOption "Enable git";
    custom.shell.git.userEmail = lib.mkOption {
      type = lib.types.str;
      default = "git@ethanbrady.xyz";
      description = "The email address to use for git commits";
    };
    custom.shell.git.userName = lib.mkOption {
      type = lib.types.str;
      default = "EthanJ-Brady";
      description = "The name to use for git commits";
    };
  };

  config = lib.mkIf config.custom.shell.git.enable {
    programs.git = {
      enable = true;
      userEmail = config.custom.shell.git.userEmail;
      userName = config.custom.shell.git.userName;
      extraConfig = {
        advice.skippedCherryPicks = false;
        push.autoSetupRemote = true;
      };
      delta = {
        enable = true;
        options = {
          line-numbers = true;
          side-by-side = true;
        };
      };
      aliases = {
        graph = "log --oneline --graph --decorate --all";
        s = "status -s";
        l = "log --oneline";
        d = "diff --name-status";
        last = "log -1 HEAD";
      };
    };
  };
}
