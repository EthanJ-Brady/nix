{
  config,
  lib,
  ...
}: let
  frappe = builtins.fetchurl {
    url = "https://github.com/catppuccin/swaync/releases/download/v0.2.3/frappe.css";
    sha256 = "1y7wmh2f8v5qxpiai7jhxv0rg92h4g4s6ljddvwn80z9n6iypxzn";
  };
in {
  config = lib.mkIf (config.catppuccin.enable && config.custom.desktop.hyprland.enable) {
    services.swaync.style = builtins.readFile frappe;
  };
}
