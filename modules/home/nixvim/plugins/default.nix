{
  config,
  lib,
  ...
}:
{
  imports = [
    ./gitsigns.nix
    ./whichkey.nix
  ];

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim.plugins = {
      sleuth.enable = true;
    };
  };
}
