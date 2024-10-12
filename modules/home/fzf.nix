{ config, lib, ... }:
{
  options = {
    fzf.enable = lib.mkEnableOption "Enables fzf integration into the shell";
  };

  config = {
    fzf.enable = lib.mkDefault true;

    programs.fzf = lib.mkIf config.fzf.enable {
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
