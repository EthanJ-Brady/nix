{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./bat.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./nixvim
    ./oh-my-posh
    ./tmux.nix
    ./zettel
    ./zoxide.nix
    ./zsh.nix
  ];

  options = {
    custom.shell.enable = lib.mkEnableOption "Enables the shell and configuration";
  };

  config = lib.mkIf config.custom.shell.enable {
    custom.shell = {
      bat.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      fzf.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      nixvim.enable = lib.mkDefault true;
      oh-my-posh.enable = lib.mkDefault true;
      tmux.enable = lib.mkDefault true;
      zettel.enable = lib.mkDefault true;
      zoxide.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
    };

    home.packages = [
      inputs.sourceweaver.packages.${pkgs.system}.default
    ];
  };
}
