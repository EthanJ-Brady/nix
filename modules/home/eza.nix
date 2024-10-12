{ config, lib, ... }:
{
  options = {
    eza.enable = lib.mkEnableOption "Enables eza and creates shell aliases for it.";
  };

  config = {
    eza.enable = lib.mkDefault true;

    programs = lib.mkIf config.eza.enable {
      eza = {
        enable = true;
        enableZshIntegration = true;
        git = true;
        icons = true;
      };

      zsh.shellAliases.ls = "eza";
      zsh.shellAliases.ll = "eza -lh";
      zsh.shellAliases.l = "eza -lah";
      zsh.shellAliases.tree = "eza -T";
    };
  };
}
