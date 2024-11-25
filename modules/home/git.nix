{ config, lib, ... }:
{
  options = {
    git.enable = lib.mkEnableOption "Enable git";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
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
      };
    };
  };
}
