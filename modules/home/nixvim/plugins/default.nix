{
  config,
  lib,
  ...
}:
{
  imports = [
    ./format.nix
    ./gitsigns.nix
    ./hardtime.nix
    ./lsp.nix
    ./lualine.nix
    ./mini.nix
    ./oil.nix
    ./supermaven.nix
    ./telescope.nix
    ./treesitter.nix
    ./todo-comments.nix
    ./whichkey.nix
  ];

  config = lib.mkIf config.nixvim.enable {
    nixvim.plugins = {
      hardtime.enable = lib.mkDefault false;
    };

    programs.nixvim.plugins = {
      sleuth.enable = true;
    };
  };
}
