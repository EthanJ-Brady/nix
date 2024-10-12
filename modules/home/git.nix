{ config, lib, ... }:
{
  options = {
    git.enable = lib.mkEnableOption "Enable git";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      aliases = {
        graph = "log --oneline --graph --decorate --all";
        s = "status -s";
      };
    };
  };
}
