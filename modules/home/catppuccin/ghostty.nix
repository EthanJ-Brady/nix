{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.catppuccin.enable && config.custom.desktop.ghostty.enable) {
    programs.ghostty.settings.theme = "catppuccin-${lib.strings.toLower config.catppuccin.flavor}";
  };
}
