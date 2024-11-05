{ config, lib, ... }:
{
  options = {
    bat.enable = lib.mkEnableOption "Enable bat and cat shell alias";
  };

  config = lib.mkIf config.bat.enable {
    programs = {
      bat.enable = true;
      zsh.shellAliases.cat = "bat";
    };
  };
}
