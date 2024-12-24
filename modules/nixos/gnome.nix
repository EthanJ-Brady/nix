{
  config,
  lib,
  pkgs,
}:
{
  options = {
    gnome.enable = lib.mkEnableOption "Enables the gnome desktop environment";
  };

  config = lib.mkIf config.gnome.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    services.gnome.core-utilities.enable = false;
    environment.gnome.excludePackages = [ pkgs.gnome-tour ];
    environment.systemPackages = with pkgs; [
        gnome.adwaita-icon-theme
        gnome.gnome-tweaks
    ];
  };
}
