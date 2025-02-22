{
  config,
  pkgs,
  ...
}: {
  bat.enable = true;
  bun.enable = true;
  catppuccin.enable = true;
  eza.enable = true;
  fzf.enable = true;
  git.enable = true;
  ghostty.enable = true;
  nixvim.enable = true;
  oh-my-posh.enable = true;
  ssh.enable = true;
  tmux.enable = true;
  zettel.enable = true;
  zoxide.enable = true;
  zsh.enable = true;

  programs.git.userEmail = "git@ethanbrady.xyz";
  programs.git.userName = "EthanJ-Brady";

  home.username = "mohs";
  home.homeDirectory = "/home/mohs";

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
