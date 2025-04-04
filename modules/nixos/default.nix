{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./bootloader.nix
    ./cloud
    ./desktop
    ./docker.nix
    ./gaming.nix
    ./hardware
    ./homelab
    ./locale.nix
    ./network
    ./obs.nix
    ./user.nix
  ];

  options = {
    custom.enable = lib.mkEnableOption "Enables default custom configuration for NixOS";
  };

  config = lib.mkIf config.custom.enable {
    custom.locale.enable = lib.mkDefault true;
    custom.network.enable = lib.mkDefault true;
    custom.user.enable = lib.mkDefault true;
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
