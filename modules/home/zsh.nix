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
        autosuggestion.enable = true;
        # This is only here to make the up arrow key only suggest commands that match the already typed in characters. If there is a better way to do this, I should probably change this.
        oh-my-zsh.enable = true; 
      };
    };
  };
}
