{ lib, ... }:
{
  imports = [
    ../../modules/home/git.nix
  ];

  git.enable = lib.mkDefault true;
}
