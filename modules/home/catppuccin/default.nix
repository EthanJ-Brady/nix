{ lib, ... }:
{
  imports = [
    ./tmux.nix
  ];

  options = {
    catppuccin.enable = lib.mkEnableOption "Enables catppuccin theme across any programs that support it";
    catppuccin.flavor = lib.mkOption {
      type = lib.types.enum [ "latte" "frappe" "macchiato" "mocha" ];
      default = "frappe";
      description = "The flavor of the theme to use";
    };
  };

  config = {
    catppuccin.enable = lib.mkDefault true;
  };
}
