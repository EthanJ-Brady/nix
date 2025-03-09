{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.catppuccin.enable && config.custom.shell.tmux.enable) {
    programs.tmux.plugins = [
      {
        plugin = pkgs.tmuxPlugins.catppuccin.overrideAttrs (oldAttrs: {
          version = "v2.1.2";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "tmux";
            rev = "v2.1.2";
            sha256 = "sha256-vBYBvZrMGLpMU059a+Z4SEekWdQD0GrDqBQyqfkEHPg=";
          };
        });
        extraConfig = ''
          set -g @catppuccin_flavor "${lib.strings.toLower config.catppuccin.flavor}"
          set -g @catppuccin_status_background "none"

          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_text "#W"
          set -g @catppuccin_window_current_text "#W"

          set -g status-left ""
          set -g status-right ""
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_directory}"
        '';
      }
    ];
  };
}
# set -g @catppuccin_flavour "${lib.strings.toLower config.catppuccin.flavor}"
# set -g @catppuccin_window_left_separator " "
# set -g @catppuccin_window_right_separator " "
# set -g @catppuccin_window_middle_separator " █"
# set -g @catppuccin_window_number_position "right"
#
# set -g @catppuccin_window_default_fill "number"
# set -g @catppuccin_window_default_text "#W"
#
# set -g @catppuccin_window_current_fill "number"
# set -g @catppuccin_window_current_text "#W"
#
# set -g @catppuccin_status_modules_right "directory session"
# set -g @catppuccin_status_left_separator  " "
# set -g @catppuccin_status_right_separator ""
# set -g @catppuccin_status_fill "icon"
# set -g @catppuccin_status_connect_separator "no"
#
# set -g @catppuccin_directory_text "#{pane_current_path}"

