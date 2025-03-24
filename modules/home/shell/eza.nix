{
  config,
  lib,
  ...
}: {
  options = {
    custom.shell.eza.enable = lib.mkEnableOption "Enables eza and creates shell aliases for it.";
  };

  config = lib.mkIf config.custom.shell.eza.enable {
    programs = {
      eza = {
        enable = true;
        enableZshIntegration = true;
        git = true;
        icons = "auto";
      };

      zsh = lib.mkIf config.custom.shell.zsh.enable {
        shellAliases.ls = "eza";
        shellAliases.ll = "eza -lh";
        shellAliases.l = "eza -lah";
        shellAliases.tree = "eza -T";
      };
    };
  };
}
