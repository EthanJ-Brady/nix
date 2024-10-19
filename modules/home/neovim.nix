{
  config,
  lib,
  ...
}:
{
  options = {
    neovim.enable = lib.mkEnableOption "Enables the neovim distribution nixvim";
  };

  config = {
    neovim.enable = lib.mkDefault true;

    programs.nixvim = lib.mkIf config.neovim.enable {
      enable = true;
      colorscheme = "onedark";
      colorschemes."onedark".enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      opts = {
        number = true; # Display line numbers on the left side of the editor
        relativenumber = true; # Show relative line numbers
        laststatus = 3; # Always display the status line at the bottom, even with only one window open
        clipboard = "unnamedplus"; # Integrate with system clipboard
        cursorline = true; # Highlight the entire line where the cursor is currently positioned
        cursorlineopt = "number"; # Only highlight the line number of the current cursor position
        expandtab = true; # Convert tabs to spaces when inserting
        shiftwidth = 2; # Set the number of spaces for each level of indentation when using '>' or '<' commands
        smartindent = true; # Automatically indent new lines based on the previous line's indentation
        tabstop = 2; # Define the width of a tab character as 2 spaces
        softtabstop = 2; # Make backspace treat 2 spaces as a tab when deleting
        ignorecase = true; # Make searches case-insensitive by default
        smartcase = true; # Override ignorecase if search pattern contains uppercase characters
        numberwidth = 2; # Set the minimum width of the line number column
        ruler = false; # Disable displaying cursor position in the bottom right corner
        signcolumn = "yes"; # Always show the sign column for git indicators, linter warnings, etc.
        splitbelow = true; # Open new horizontal splits below the current window
        splitright = true; # Open new vertical splits to the right of the current window
        timeoutlen = 400; # Set the time (in milliseconds) to wait for a mapped sequence to complete
        undofile = true; # Persist undo history between editing sessions
        fillchars = {
          eob = " "; # Replace the '~' character at the end of buffer with a space
        };
        scrolloff = 8; # Keep at least 8 lines above and below the cursor when scrolling
      };

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
      ];

      plugins = {
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
              { name = "luasnip"; }
            ];
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-e>" = "cmp.mapping.close()";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
          };
        };
        indent-blankline = {
          enable = true;
          settings = {
            indent = {
              char = "│";
            };
          };
        };
        lsp = {
          enable = true;
          servers = {
            ts_ls.enable = true;
            lua_ls.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
          };
        };
        lualine = {
          enable = true;
        };
        neoscroll = {
          enable = true;
        };
        nvim-tree = {
          autoClose = true;
          enable = true;
          hijackCursor = true;
        };
        telescope = {
          enable = true;
        };
        treesitter = {
          enable = true;
        };
        web-devicons = {
          enable = true;
        };
        which-key = {
          enable = true;
        };
      };
    };
  };
}
