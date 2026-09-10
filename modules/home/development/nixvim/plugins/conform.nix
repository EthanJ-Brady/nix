{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.development;
  inherit (config.lib.nixvim) mkRaw;
  projectFormatters = mkRaw ''require("project-formatters").formatters'';
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      globals.autoformat = lib.mkDefault true;
      extraFiles = {
        "lua/project-formatters.lua".source = ./project-formatters.lua;
        "oxfmt-default.json".text = "{}";
      };
      extraPackagesAfter = with pkgs; [
        alejandra
        biome
        black
        oxfmt
        prettier
        rustfmt
      ];

      keymaps = [
        {
          key = "<leader>uf";
          mode = "n";
          action = mkRaw ''
            function()
              vim.g.autoformat = not vim.g.autoformat
              vim.notify("Auto Format (Global): " .. (vim.g.autoformat and "On" or "Off"))
            end
          '';
          options = {
            desc = "Toggle Auto Format (Global)";
            silent = true;
          };
        }
        {
          key = "<leader>uF";
          mode = "n";
          action = mkRaw ''
            function()
              local enabled = vim.b.autoformat
              if enabled == nil then
                enabled = vim.g.autoformat ~= false
              end
              vim.b.autoformat = not enabled
              vim.notify("Auto Format (Buffer): " .. (vim.b.autoformat and "On" or "Off"))
            end
          '';
          options = {
            desc = "Toggle Auto Format (Buffer)";
            silent = true;
          };
        }
      ];

      plugins.conform-nvim = {
        autoInstall.enable = lib.mkDefault false;
        enable = lib.mkDefault true;
        settings = {
          default_format_opts = {
            lsp_format = lib.mkDefault "fallback";
            timeout_ms = lib.mkDefault 2000;
            stop_after_first = lib.mkDefault true;
          };
          formatters = {
            oxfmt = lib.mkDefault (mkRaw ''require("project-formatters").override("oxfmt")'');
            prettier = lib.mkDefault (mkRaw ''require("project-formatters").override("prettier")'');
            biome = lib.mkDefault (mkRaw ''require("project-formatters").override("biome")'');
            rustfmt.cwd = lib.mkDefault (mkRaw ''function(_, ctx) return ctx.dirname end'');
            project_formatter_error = lib.mkDefault (mkRaw ''require("project-formatters").blocked'');
          };
          format_on_save = lib.mkDefault (mkRaw ''
            function(bufnr)
              if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
                return
              end

              return {}
            end
          '');
          formatters_by_ft = {
            css = lib.mkDefault projectFormatters;
            html = lib.mkDefault projectFormatters;
            javascript = lib.mkDefault projectFormatters;
            javascriptreact = lib.mkDefault projectFormatters;
            json = lib.mkDefault projectFormatters;
            jsonc = lib.mkDefault projectFormatters;
            nix = lib.mkDefault [
              "alejandra"
            ];
            python = lib.mkDefault [
              "black"
            ];
            rust = lib.mkDefault [
              "rustfmt"
            ];
            typescript = lib.mkDefault projectFormatters;
            typescriptreact = lib.mkDefault projectFormatters;
          };
          notify_on_error = lib.mkDefault true;
          notify_no_formatters = lib.mkDefault false;
        };
      };
    };
  };
}
