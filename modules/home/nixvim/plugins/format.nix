{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.nixvim.enable {
    home.packages = with pkgs; [
      black
    ];

    programs.nixvim.plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 2000;
          stop_after_first = true;
        };
        formatters_by_ft = {
          python = [
            "black"
          ];
          javascript = [
            "prettierd"
            "prettier"
          ];
          javascriptreact = [
            "prettierd"
            "prettier"
          ];
          json = [
            "prettierd"
            "prettier"
          ];
          markdown = [
            "prettierd"
            "prettier"
          ];
          typescript = [
            "prettierd"
            "prettier"
          ];
          typescriptreact = [
            "prettierd"
            "prettier"
          ];
        };
        notify_on_error = false;
        notify_no_formatters = false;
      };
    };
  };
}
