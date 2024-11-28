{ config, lib, ... }:
{
  options = {
    eza.enable = lib.mkEnableOption "Enables eza and creates shell aliases for it.";
  };

  config = lib.mkIf config.eza.enable {
    programs = {
      eza = {
        enable = true;
        enableZshIntegration = true;
        git = true;
        icons = "auto";
      };

      zsh = lib.mkIf config.zsh.enable {
        shellAliases.ls = "eza";
        shellAliases.ll = "eza -lh";
        shellAliases.l = "eza -lah";
        shellAliases.tree = "eza -T";
      };
    };
  };
}
