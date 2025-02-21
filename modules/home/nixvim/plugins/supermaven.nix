{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.nixvim.enable && config.nixvim.ai-codewriter == "supermaven") {
    programs.nixvim = {
      plugins.cmp.settings.sources = [
        {name = "supermaven";}
      ];
      extraPlugins = [
        {
          plugin = pkgs.vimPlugins.supermaven-nvim;
          config = "lua require(\"supermaven-nvim\").setup({disable_keymaps = true,disable_inline_completion = true,});";
        }
      ];
    };
  };
}
