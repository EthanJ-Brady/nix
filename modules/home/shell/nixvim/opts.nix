{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.custom.shell.nixvim.enable {
    programs.nixvim.opts = {
      breakindent = true; # Indent wrapped lines
      clipboard = "unnamedplus"; # Integrate with system clipboard
      cursorline = true; # Highlight the entire line where the cursor is currently positioned
      cursorlineopt = "number"; # Only highlight the line number of the current cursor position
      expandtab = true; # Convert tabs to spaces when inserting
      fillchars.eob = " "; # Replace the '~' character at the end of buffer with a space
      inccommand = "split"; # Incremental search
      ignorecase = true; # Make searches case-insensitive by default
      laststatus = 3; # Always display the status line at the bottom, even with only one window open
      list = true; # Show whitespace
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      number = true; # Display line numbers on the left side of the editor
      numberwidth = 2; # Set the minimum width of the line number column
      relativenumber = true; # Show relative line numbers
      ruler = false; # Disable displaying cursor position in the bottom right corner
      scrolloff = 8; # Keep at least 8 lines above and below the cursor when scrolling
      shiftwidth = 2; # Set the number of spaces for each level of indentation when using '>' or '<' commands
      showmode = false; # Don't show the current mode since it's in the status line
      smartindent = true; # Automatically indent new lines based on the previous line's indentation
      softtabstop = 2; # Make backspace treat 2 spaces as a tab when deleting
      signcolumn = "yes"; # Always show the sign column for git indicators, linter warnings, etc.
      smartcase = true; # Override ignorecase if search pattern contains uppercase characters
      splitbelow = true; # Open new horizontal splits below the current window
      splitright = true; # Open new vertical splits to the right of the current window
      tabstop = 2; # Define the width of a tab character as 2 spaces
      timeoutlen = 400; # Set the time (in milliseconds) to wait for a mapped sequence to complete
      undofile = true; # Persist undo history between editing sessions
    };
  };
}
