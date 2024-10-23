{ config, lib, ... }:
{
  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh customizations";
  };

  config = {
    zsh.enable = lib.mkDefault true;

    programs = lib.mkIf config.zsh.enable {
      zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
      };
    };
  };
}
