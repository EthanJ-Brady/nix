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
        terminal = "screen-256color";
        shell = "\$SHELL";
        sensibleOnTop = true;
        prefix = "C-Space";
        plugins = with pkgs; [
          {
            # This plugin allows you to interoperably navigate between tmux and nvim with ctrl + left/up/right/down or nvim directional keys
            plugin = tmuxPlugins.vim-tmux-navigator;
            extraConfig = ''
              is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
                  | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"

              bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
              bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
              bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
              bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

              tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
              if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
                  "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
              if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
                  "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

              bind-key -T copy-mode-vi 'C-h' select-pane -L
              bind-key -T copy-mode-vi 'C-j' select-pane -D
              bind-key -T copy-mode-vi 'C-k' select-pane -U
              bind-key -T copy-mode-vi 'C-l' select-pane -R
              bind-key -T copy-mode-vi 'C-\' select-pane -l

              bind-key -n C-Up select-pane -U
              bind-key -n C-Down select-pane -D
              bind-key -n C-Left select-pane -L
              bind-key -n C-Right select-pane -R

              bind-key -n 'C-Left' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
              bind-key -n 'C-Down' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
              bind-key -n 'C-Up' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
              bind-key -n 'C-Right' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
            '';
          }
          tmuxPlugins.onedark-theme
        ];
        # At least on Mac, this line was needed to get tmux to use zsh instead of sh
        extraConfig = ''
          set -g default-command $SHELL
        '';
      };
    };
  };
}
