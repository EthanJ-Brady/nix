{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.custom.shell.nixvim.enable {
    programs.nixvim.plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          experimental.ghost_text = true;
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-y>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "path";}
          ];
          window = {
            completion.__raw = "cmp.config.window.bordered()";
            documentation.__raw = "cmp.config.window.bordered()";
          };
        };
      };
      lsp = {
        enable = true;
        servers = {
          cssls.enable = true;
          eslint.enable = true;
          jdtls.enable = true;
          jsonnet_ls.enable = true;
          lua_ls.enable = true;
          marksman.enable = true;
          nixd = {
            enable = true;
            settings = {
              nixpkgs.expr = "import <nixpkgs> { }";
            };
          };
          pyright.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          texlab.enable = true;
          ts_ls.enable = lib.mkDefault true;
        };
      };
    };
  };
}
