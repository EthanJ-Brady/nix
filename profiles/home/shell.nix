{ lib, ... }:
{
  imports = [
    ../../modules/home/bat.nix
    ../../modules/home/eza.nix
    ../../modules/home/fzf.nix
    ../../modules/home/oh-my-posh
    ../../modules/home/tmux.nix
    ../../modules/home/zoxide.nix
    ../../modules/home/zsh.nix
  ];

  bat.enable = lib.mkDefault true;
  eza.enable = lib.mkDefault true;
  fzf.enable = lib.mkDefault true;
  oh-my-posh.enable = lib.mkDefault true;
  tmux.enable = lib.mkDefault true;
  zoxide.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
}
