{ config, lib, ... }:
{
  options = {
    bat.enable = lib.mkEnableOption "Enable bat and cat shell alias";
  };

  config = {
    bat.enable = lib.mkDefault true;

    programs = lib.mkIf config.bat.enable {
      bat.enable = true;
      zsh.shellAliases.cat = "bat";
    };
  };
}