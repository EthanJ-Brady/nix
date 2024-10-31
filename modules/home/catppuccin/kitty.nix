{ config, lib, ... }:
{
  config = lib.mkIf (config.catppuccin.enable && config.kitty.enable) {
    programs.kitty.themeFile = "Catppuccin-${config.catppuccin.flavor}";
  };
}
