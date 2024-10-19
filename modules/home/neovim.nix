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
      };
    };
  };
}
