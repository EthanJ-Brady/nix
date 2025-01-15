{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (config.catppuccin.enable && config.zellij.enable) {
    home.file.".config/zellij/config.kdl".text = lib.mkAfter "theme \"catppuccin-${lib.strings.toLower config.catppuccin.flavor}\"";
  };
}
