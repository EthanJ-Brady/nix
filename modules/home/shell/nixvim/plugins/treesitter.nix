{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.custom.shell.nixvim.enable {
    programs.nixvim = {
      opts = {
        foldmethod = "expr";
        foldexpr = "nvim_treesitter#foldexpr()";
        foldlevel = 99;
      };
      plugins.treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
          indent.enable = true;
        };
      };
    };
  };
}
