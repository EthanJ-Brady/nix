{ lib, ... }:
{
  imports = [
    ../../modules/home/catppuccin
  ];

  catppuccin.enable = lib.mkDefault true;
}
