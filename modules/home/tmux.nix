{ config, lib, ... }:
{
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux along with it's corresponding configuration";
  };

  config = {
    tmux.enable = lib.mkDefault true;

    programs = lib.mkIf config.tmux.enable {
      tmux = {
        enable = true;
        sensibleOnTop = true;
      };
    };
  };
}
