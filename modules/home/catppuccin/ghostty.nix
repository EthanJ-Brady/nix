{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (config.catppuccin.enable && config.ghostty.enable) {
    programs.ghostty.settings.theme = "catppuccin-${lib.strings.toLower config.catppuccin.flavor}";
  };
}
