{ config, lib, ... }:
{
  options = {
    zsh.enable = lib.mkEnableOption "Enable zsh customizations";
  };

  config =  lib.mkIf config.zsh.enable {
    programs = {
      zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        autosuggestion.enable = true;
        # This is only here to make the up arrow key only suggest commands that match the already typed in characters. If there is a better way to do this, I should probably change this.
        oh-my-zsh.enable = true; 
        shellAliases = {
          "nvim-kickstart" = "NVIM_APPNAME=\"nvim-kickstart\" nvim";
        };
        initExtra = ''
          # Enables vim mode for zsh
          bindkey -v
        '';
      };
    };
  };
}
