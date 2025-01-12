{ ... }:
{
    profiles.apps = true;
    profiles.programming = true;
    profiles.shell = true;
    profiles.theme = true;

    ssh.enable = true;
    nixvim.enable = true;
    zettel.enable = true;
    hyprland.enable = true;

    wayland.windowManager.hyprland = {
      # Determine monitors with `hyprctl monitors all`
      monitor = [
        "eDP-1,disable"
        "HDMI-A-1,2560x1440@144,0x0,1"
        "DP-1,1920x1080@60,2560x0,1"
      ];
    };

    home.username = "ethan";
    home.homeDirectory = "/home/ethan";

    home.stateVersion = "23.11";

    programs.home-manager.enable = true;
}
