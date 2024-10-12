{ config, lib, ... }:
{
  options = {
    zoxide.enable = lib.mkEnableOption "Enable zoxide and cd shell alias";
  };

  config = {
    zoxide.enable = lib.mkDefault true;

    programs = lib.mkIf config.zoxide.enable {
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh.shellAliases.cd = "z";
    };
  };
}
