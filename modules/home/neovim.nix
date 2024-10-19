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
      opts = {
        number = true; # Show line numbers
        relativenumber = true; # Show relative line numbers
        shiftwidth = 2; # Tab width should be 2
      };
    };
  };
}
