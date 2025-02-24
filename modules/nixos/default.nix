{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./bootloader.nix
    ./desktop
    ./gaming.nix
    ./gnome.nix
    ./hardware
    ./homelab
    ./locale.nix
    ./obs.nix
    ./user.nix
    ./ssh.nix
  ];

  options = {
    custom.enable = lib.mkEnableOption "Enables default custom configuration for NixOS";
  };

  config = lib.mkIf config.custom.enable {
    environment.systemPackages = with pkgs; [
      ghostty
    ];
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];
    networking.networkmanager.enable = lib.mkDefault true;
    nix.settings.experimental-features = [
      "flakes"
      "nix-command"
    ];
    nixpkgs.config.allowUnfree = lib.mkDefault true;
    security.sudo.wheelNeedsPassword = lib.mkDefault false;
  };
}
