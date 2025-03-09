{lib, ...}: {
  imports = [
    ./ghostty.nix
    ./nixvim.nix
    ./swaync.nix
    ./tmux.nix
    ./waybar
    ./wofi
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
