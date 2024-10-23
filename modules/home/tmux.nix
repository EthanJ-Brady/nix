{ pkgs, config, lib, ... }:
{
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux along with it's corresponding configuration";
  };

  config = {
    tmux.enable = lib.mkDefault true;

    programs = lib.mkIf config.tmux.enable {
      tmux = {
        enable = true;
        shell = "${pkgs.zsh}/bin/zsh";
        sensibleOnTop = true;
        plugins = with pkgs; [
          {
            # This plugin allows you to interoperably navigate between tmux and nvim with ctrl + left/up/right/down or nvim directional keys
            plugin = tmuxPlugins.vim-tmux-navigator;
            extraConfig = ''
              set -g @vim_navigator_mapping_left "C-Left C-h"
              set -g @vim_navigator_mapping_right "C-Right C-l"
              set -g @vim_navigator_mapping_up "C-Up C-k"
              set -g @vim_navigator_mapping_down "C-Down C-j"
            '';
          }
          tmuxPlugins.onedark-theme
        ];
      };
    };
  };
}
