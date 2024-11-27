{
  config,
  lib,
  ...
}:
{
  imports = [
    ./gitsigns.nix
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
