{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim.keymaps = [
      {
        action = "<cmd>nohlsearch<CR>";
        key = "<Esc>";
        mode = "n";
        options = {
          desc = "clear search highlight";
          silent = true;
        };
      }
      {
        action = "<cmd>lua vim.diagnostic.setloclist()<CR>";
        key = "<leader>q";
        mode = "n";
        options = {
          desc = "Open diagnostic [Q]uickfix list";
          silent = true;
        };
      }
      {
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        key = "<leader>rn";
        mode = "n";
        options = {
          desc = "[R]e[n]ame symbol";
          silent = true;
        };
      }
      {
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        key = "<leader>ca";
        mode = ["n" "x"];
        options = {
          desc = "[C]ode [A]ction";
          silent = true;
        };
      }
      {
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
        key = "<leader>gD";
        mode = "n";
        options = {
          desc = "[G]o to [d]eclaration";
          silent = true;
        };
      }
      {
        action = "<C-u>";
        key = "<PageUp>";
        mode = [
          "n"
          "i"
          "v"
        ];
        options = {
          remap = true;
          desc = "scroll up";
          silent = true;
        };
      }
      {
        action = "<C-d>";
        key = "<PageDown>";
        mode = [
          "n"
          "i"
          "v"
        ];
        options = {
          remap = true;
          desc = "scroll down";
          silent = true;
        };
      }
      {
        action = "h";
        key = "<Left>";
        options = {
          remap = true;
          silent = true;
        };
      }
      {
        action = "j";
        key = "<Down>";
        options = {
          remap = true;
          silent = true;
        };
      }
      {
        action = "k";
        key = "<Up>";
        options = {
          remap = true;
          silent = true;
        };
      }
      {
        action = "l";
        key = "<Right>";
        options = {
          remap = true;
          silent = true;
        };
      }
    ];
  };
}
