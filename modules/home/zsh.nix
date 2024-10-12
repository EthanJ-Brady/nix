{ config, lib, ... }:
{
  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh customizations";
  };

  config = {
    zsh.enable = lib.mkDefault true;

    programs.zsh = lib.mkIf config.zoxide.enable {
      enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "awesomepanda";
        plugins = [
          "git"
        ];
      };
    };
  };
}
