{pkgs, ...}: {
  custom = {
    enable = true;
  };
  catppuccin.enable = true;

  home.packages = with pkgs; [
    tldr
    neofetch
  ];

  home.username = "ethan";
  home.homeDirectory = "/home/ethan";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
