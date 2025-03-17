{
  config,
  lib,
  ...
}: {
  options = {
    custom.shell.bat.enable = lib.mkEnableOption "Enable bat and cat shell alias";
  };

  config = lib.mkIf config.custom.shell.bat.enable {
    programs = {
      bat.enable = true;
      zsh.shellAliases.cat = "bat";
    };
  };
}
