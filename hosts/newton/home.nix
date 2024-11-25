{ pkgs, ... }:

{
  # Profiles
  profiles.apps = true;
  profiles.programming = true;
  profiles.shell = true;
  profiles.theme = true;

  ssh.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  home.homeDirectory = "/Users/ethanbrady";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.firefox = {
    package = pkgs.firefox-bin;
  };

  home.packages = with pkgs; [ 
    tlrc
  ];
}
