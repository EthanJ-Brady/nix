{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    kitty.enable = lib.mkEnableOption "Enables kitty terminal emulator";
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "FiraCode Nerd Font";
        size = 14;
        package = pkgs.nerd-fonts.fira-code;
      };
      extraConfig = ''
        hide_window_decorations titlebar-only
        window_padding_width 8
        background_opacity 0.9
        background_blur 32
      '';
    };
  };
}
