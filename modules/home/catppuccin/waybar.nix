{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (config.catppuccin.enable && config.waybar.enable) {
    programs.waybar.style = lib.mkAfter ''
      @import "${lib.strings.toLower config.catppuccin.flavor}.css";
    '';

    home.file = {
      ".config/waybar/latte.css".source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/waybar/ee8ed32b4f63e9c417249c109818dcc05a2e25da/themes/latte.css";
        sha256 = "sha256-Dwu9uKlTOQIZ9duO6B3fhRT4I7r6aDTzjnHXLsD5kYA=";
      };
      ".config/waybar/frappe.css".source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/waybar/ee8ed32b4f63e9c417249c109818dcc05a2e25da/themes/frappe.css";
        sha256 = "sha256-nTUu7DsjEX+hChKIL26MP0G7aBoGQa1/kchJRxq6fuI=";
      };
      ".config/waybar/macchiato.css".source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/waybar/ee8ed32b4f63e9c417249c109818dcc05a2e25da/themes/macchiato.css";
        sha256 = "sha256-c+gJNGVG3PFztb7OjvL8ejckPtesxnVV+SUSsYxejXU=";
      };
      ".config/waybar/mocha.css".source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/waybar/ee8ed32b4f63e9c417249c109818dcc05a2e25da/themes/mocha.css";
        sha256 = "sha256-puMFl8zIKOiYhE6wzqnffXOHn/VnKmpVDzrMJMk+3Rc=";
      };
    };
  };
}
