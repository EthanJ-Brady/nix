{
  config,
  lib,
  ...
}:
{
  imports = [
    ./gitsigns.nix
    ./mini.nix
    ./oil.nix
    ./telescope.nix
    ./treesitter.nix
    ./todo-comments.nix
    ./whichkey.nix
  ];

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim.plugins = {
      sleuth.enable = true;
      tmux-navigator.enable = true;
    };
  };
}
