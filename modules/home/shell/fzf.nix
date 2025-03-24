{
  config,
  lib,
  ...
}: {
  options = {
    custom.shell.fzf.enable = lib.mkEnableOption "Enables fzf integration into the shell";
  };

  config = lib.mkIf config.custom.shell.fzf.enable {
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
