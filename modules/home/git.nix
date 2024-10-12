{ config, lib, ... }:
{
  options = {
    git.enable = lib.mkEnableOption "Enable git";
  };

  config = {
    git.enable = lib.mkDefault true;

    programs.git = lib.mkIf config.git.enable {
      enable = true;
      aliases = {
        graph = "log --oneline --graph --decorate --all";
        s = "status -s";
      };
    };
  };
}
