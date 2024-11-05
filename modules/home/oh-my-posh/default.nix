{ config, lib, ... }:
{
  options = {
    oh-my-posh.enable = lib.mkEnableOption "Enable the oh my posh prompt for the terminal";
  };

  config = lib.mkIf config.oh-my-posh.enable {
    programs = {
      oh-my-posh = {
        enable = true;
        enableZshIntegration = true;
        settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./config.json));
      };
    };
  };
}
