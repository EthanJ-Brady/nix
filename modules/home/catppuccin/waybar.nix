{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (config.catppuccin.enable && config.waybar.enable) {
    home.file = {
      ".config/waybar/frappe.css".source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/waybar/ee8ed32b4f63e9c417249c109818dcc05a2e25da/themes/frappe.css";
        sha256 = "sha256-nTUu7DsjEX+hChKIL26MP0G7aBoGQa1/kchJRxq6fuI=";
      };
    };
  };
}
