{
  config,
  lib,
  ...
}: {
  options = {
    zoxide.enable = lib.mkEnableOption "Enable zoxide and cd shell alias";
  };

  config = lib.mkIf config.zoxide.enable {
    programs = {
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = lib.mkIf config.zsh.enable {
        shellAliases.cd = "z";
      };
    };
  };
}
