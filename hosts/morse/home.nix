{pkgs, ...}: {
  bat.enable = true;
  catppuccin.enable = true;
  eza.enable = true;
  fzf.enable = true;
  # ghostty.enable = true;
  git.enable = true;
  nixvim.enable = true;
  oh-my-posh.enable = true;
  ssh.enable = true;
  # tmux.enable = true;
  # zettel.enable = true;
  zoxide.enable = true;
  zsh.enable = true;

  programs.git.userEmail = "git@ethanbrady.xyz";
  programs.git.userName = "EthanJ-Brady";

  home.username = "ethan";
  home.homeDirectory = "/home/ethan";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    tldr
    neofetch
  ];
}
