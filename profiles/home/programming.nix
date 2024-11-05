{ lib, ... }:
{
  imports = [
    ../../modules/home/git.nix
    ../../modules/home/lazygit.nix
  ];

  git.enable = lib.mkDefault true;
  lazygit.enable = lib.mkDefault true;
}
