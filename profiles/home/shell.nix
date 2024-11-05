{ config, lib, ... }:
{
  options = {
    profiles.shell = lib.mkEnableOption "Enables shell related tools";
  };

  config = lib.mkIf config.profiles.shell {
    bat.enable = lib.mkDefault true;
    eza.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    oh-my-posh.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
  };
}
