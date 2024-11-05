{ config, lib, ... }:
{
  options = {
    fzf.enable = lib.mkEnableOption "Enables fzf integration into the shell";
  };

  config = lib.mkIf config.fzf.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      fileWidgetOptions = [
        "-i"
        "-e"
      ];
      historyWidgetOptions = [
        "-i"
        "-e"
      ];
    };
  };
}
