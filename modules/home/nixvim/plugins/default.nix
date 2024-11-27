{
  config,
  lib,
  ...
}:
{
  imports = [
    ./gitsigns.nix
    ./mini.nix
    ./telescope.nix
    ./todo-comments.nix
    ./whichkey.nix
  ];

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim.plugins = {
      sleuth.enable = true;
    };
  };
}
