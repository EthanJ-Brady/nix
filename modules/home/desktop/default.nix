{
  config,
  lib,
  pkgs,
  ...
}: let
  isLinux = pkgs.stdenv.isLinux;
in {
  imports = [
    ./banana-cursor.nix
    ./ghostty.nix
    ./hyprland
    ./tofi.nix
    ./waybar.nix
    ./wofi.nix
  ];

  options = {
    custom.desktop.enable = lib.mkEnableOption "Enables desktop configuration";
  };

  config = lib.mkIf config.custom.desktop.enable (
    lib.mkMerge [
      {
        custom.desktop.ghostty.enable = lib.mkDefault true;
      }

      (lib.mkIf isLinux {
        custom.desktop.bananaCursor.enable = lib.mkDefault true;
        custom.desktop.hyprland.enable = lib.mkDefault true;
        custom.desktop.waybar.enable = lib.mkDefault true;
        custom.desktop.tofi.enable = lib.mkDefault true;
      })
    ]
  );
}
