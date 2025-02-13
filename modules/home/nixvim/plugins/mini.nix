{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim.plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        ai.enable = true;
        cursorword.enable = true;
        diff.enable = true;
        git.enable = true;
        icons.enable = true;
        pairs.enable = true;
        snippets = {
          enable = true;
          snippets = {
            __raw = "{ require('mini.snippets').gen_loader.from_lang() }";
          };
        };
        starter = {
          enable = true;
          header = ''
            ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
            ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
            ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
          '';
        };
        surround.enable = true;
      };
    };
  };
}
