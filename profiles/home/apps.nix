{ lib, ... }:
{
  imports = [
    ../../modules/home/firefox.nix
    ../../modules/home/kitty.nix
  ];
  
  firefox.enable = lib.mkDefault true;
  kitty.enable = lib.mkDefault true;
}
