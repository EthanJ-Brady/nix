{pkgs, ...}: {
  custom = {
    enable = true;
    desktop.enable = true;
    gaming = {
      enable = true;
      games = {
        nethack.enable = true;
      };
    };
  };

  catppuccin.enable = true;

  wayland.windowManager.hyprland.settings = {
    # Determine monitors with `hyprctl monitors all`
    monitor = [
      "eDP-1,1920x1080@60,-1920x240,1"
      "HDMI-A-1,2560x1440@144,0x0,1"
      "DP-1,1920x1080@60,2560x-300,1,transform,1"
    ];
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "/home/ethan/Nix/static/wallpapers/frappe-maroon-duck.png";
      wallpaper = ", /home/ethan/Nix/static/wallpapers/frappe-maroon-duck.png";
    };
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
    unzip
    hyprshot
    rustc
    cargo
    bun
    brave
    nodejs_23
    ripgrep
    fd
    amberol
    prismlauncher
    graalvmPackages.graalvm-ce
  ];
}
