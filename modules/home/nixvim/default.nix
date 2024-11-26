{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./opts.nix
  ];

  options = {
    nixvim.enable = lib.mkEnableOption "Enables the neovim distribution nixvim";
  };

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      enable = true;
      globals.mapleader = " ";
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      keymaps = [
        {
          action = "<cmd>noh<CR>";
          key = "<Esc>";
          mode = "n";
          options = {
            desc = "clear search highlight";
            silent = true;
          };
        }
        {
          action = "<leader>/";
          key = "gcc";
          mode = "n";
          options = {
            desc = "toggle comment";
            remap = true;
            silent = true;
          };
        }
        {
          action = "gc";
          key = "<leader>/";
          mode = "v";
          options = {
            desc = "toggle comment";
            remap = true;
            silent = true;
          };
        }
        {
          action = "<cmd>NvimTreeToggle<CR>";
          key = "<C-n>";
          mode = "n";
          options = {
            desc = "nvimtree toggle window";
            silent = true;
          };
        }
        {
          action = "<cmd>Telescope find_files<CR>";
          key = "<leader>ff";
          mode = "n";
          options = {
            desc = "telescope find files";
            silent = true;
          };
        }
        {
          action = "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>";
          key = "<leader>fa";
          mode = "n";
          options = {
            desc = "telescope find all files";
            silent = true;
          };
        }
        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<leader>fg";
          mode = "n";
          options = {
            desc = "Find grep (live grep)";
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
          action = "<cmd>lua vim.lsp.buf.definition()<CR>";
          key = "gd";
          mode = "n";
          options = {
            desc = "Go to definition";
          };
        }
        {
          action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
          key = "gD";
          mode = "n";
          options = {
            desc = "Go to declaration";
          };
        }
        {
          action = "<cmd>lua vim.lsp.buf.rename()<CR>";
          key = "cd";
          mode = "n";
          options = {
            desc = "Change definition (rename symbol)";
          };
        }
      ];
    };
  };
}
