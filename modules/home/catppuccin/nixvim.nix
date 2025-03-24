{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.catppuccin.enable && config.custom.shell.nixvim.enable) {
    programs.nixvim = {
      colorscheme = "catppuccin";
      colorschemes.catppuccin = {
        enable = true;
        settings.flavour = "${lib.strings.toLower config.catppuccin.flavor}";
        settings.transparent_background = true;
      };
    };
  };
}
