# TODO - Add support for firefox

{ lib, ... }:
{
  imports = [
    ./ghostty.nix
    ./kitty.nix
    ./nixvim.nix
    ./tmux.nix
    ./waybar.nix
    ./wofi
    ./zellij.nix
  ];

  options = {
    catppuccin.enable = lib.mkEnableOption "Enables catppuccin theme across any programs that support it";
    catppuccin.flavor = lib.mkOption {
      type = lib.types.enum [
        "Latte"
        "Frappe"
        "Macchiato"
        "Mocha"
      ];
      default = "Frappe";
      description = "The flavor of the theme to use";
    };
  };
}
