{
  config,
  lib,
  ...
}: {
  options = {
    custom.shell.zoxide.enable = lib.mkEnableOption "Enable zoxide and cd shell alias";
  };

  config = lib.mkIf config.custom.shell.zoxide.enable {
    programs = {
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = lib.mkIf config.custom.shell.zsh.enable {
        shellAliases.cd = "z";
      };
    };
  };
}
