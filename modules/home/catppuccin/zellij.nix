{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (config.catppuccin.enable && config.zellij.enable) {
    programs.zellij.settings = {
      theme = "catppuccin-${lib.strings.toLower config.catppuccin.flavor}";
    };
  };
}
