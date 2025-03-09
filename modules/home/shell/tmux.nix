{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    custom.shell.tmux.enable = lib.mkEnableOption "Enable tmux along with it's corresponding configuration";
    custom.shell.tmux.autostart = lib.mkEnableOption "Automatically connect to a new tmux session when starting a new shell";
  };

  config = lib.mkIf config.custom.shell.tmux.enable {
    programs = {
      tmux = {
        enable = true;
        terminal = "tmux-256color";
        shell = "\$SHELL";
        sensibleOnTop = true;
        escapeTime = 0;
        mouse = true;
        prefix = "C-Space";
        keyMode = "vi";
        tmuxinator.enable = true;
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
          {
            plugin = tmuxPlugins.resurrect;
            extraConfig = ''
              # for vim
              set -g @resurrect-strategy-vim 'session'
              # for neovim
              set -g @resurrect-strategy-nvim 'session'
            '';
          }
        ];
        # At least on Mac, 'set -g default-command $SHELL' was needed to get tmux to use zsh instead of sh
        extraConfig = ''
          set -g default-command $SHELL

          set-option -g status-position top

          set -g 'status-format[1]' ""
          set -g status 2

          unbind r
          bind r source-file ~/.config/tmux/tmux.conf

          # Allow tmux to pass through to programs (Needed for yazi image viewer)
          set -g allow-passthrough all
          set -ga update-environment TERM
          set -ga update-environment TERM_PROGRAM

          # Use `v` to start selecting text
          bind -T copy-mode-vi v send -X begin-selection

          # use `y` to copy the selected text
          bind -T copy-mode-vi y send -X copy-selection-and-cancel
        '';
      };
    };

    programs.zsh.initExtraFirst = lib.mkIf config.custom.shell.tmux.autostart (
      lib.mkAfter ''
        if [ -z "$TMUX" ]; then
          tmux attach -t default || tmux new -s default
        fi
      ''
    );

    programs.nixvim.plugins = lib.mkIf config.custom.shell.nixvim.enable {
      tmux-navigator.enable = true;
    };

    home.packages = [
      pkgs.ruby
      pkgs.rubyPackages.erubi
    ];
  };
}
