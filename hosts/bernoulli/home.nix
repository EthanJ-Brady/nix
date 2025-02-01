{
  pkgs,
  ...
}:
{
  profiles.apps = true;
  profiles.programming = true;
  profiles.shell = true;
  profiles.theme = true;

  ssh.enable = true;
  nixvim.enable = true;
  zettel.enable = true;
  hyprland.enable = true;
  bananaCursor.enable = true;
  waybar.enable = true;
  wofi.enable = true;
  ghostty.enable = true;
  mangohud.enable = true;

  programs.git.userEmail = "git@ethanbrady.xyz";
  programs.git.userName = "EthanJ-Brady";

  wayland.windowManager.hyprland.settings = {
    # Determine monitors with `hyprctl monitors all`
    monitor = [
      "eDP-1,disable"
      "HDMI-A-1,2560x1440@144,0x0,1"
      "DP-1,1920x1080@60,2560x-270,1,transform,1"
    ];
  };

  home.username = "ethan";
  home.homeDirectory = "/home/ethan";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    vesktop
    tldr
    neofetch
    okular
    texliveFull
    ncpamixer
    unzip
    hyprshot
  ];
}
