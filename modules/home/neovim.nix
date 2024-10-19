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
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      opts = {
        number = true; # Show line numbers
        relativenumber = true; # Show relative line numbers
        laststatus = 3; # Always show status line
        clipboard = "unnamedplus"; # Use system clipboard
        cursorline = true; # Highlight current line
        cursorlineopt = "number"; # Highlight current line number
        expandtab = true; # Use spaces instead of tabs
        shiftwidth = 2; # Tab width should be 2
        smartindent = true; # Auto indent
        tabstop = 2; # Tab width should be 2
        softtabstop = 2; # Tab width should be 2
        ignorecase = true; # Ignore case when searching
        smartcase = true; # Ignore case when searching unless a capital letter is used
        numberwidth = 2; # Line number width
        ruler = false; # Show cursor position
        signcolumn = "yes"; # Show sign column
        splitbelow = true; # Split below
        splitright = true; # Split right
        timeoutlen = 400; # Time to wait for a mapped sequence to complete
        undofile = true; # Save undo history to a file
        fillchars = {
          eob = " "; # Use a space instead of ~
        };
      };
    };
  };
}
