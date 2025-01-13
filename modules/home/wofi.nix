{
  config,
  lib,
  ...
}:
{
  options = {
    wofi.enable = lib.mkEnableOption "Enables the wofi application launcher";
  };

  config = lib.mkIf config.wofi.enable {
    programs.wofi = {
      enable = true;
      # style = ''${builtins.readFile ./frappe.css}'';
    };

    wayland.windowManager.hyprland.settings.bind = lib.mkIf config.hyprland.enable [
      "SUPER, space, exec, wofi --show drun"
    ];
  };
}
