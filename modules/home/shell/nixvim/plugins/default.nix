{
  config,
  lib,
  ...
}: {
  imports = [
    ./avante.nix
    ./format.nix
    ./gitsigns.nix
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

  config = lib.mkIf config.custom.shell.nixvim.enable {
    programs.nixvim.plugins = {
      indent-blankline.enable = true;
      sleuth.enable = true;
    };
  };
}
