{ config, lib, ... }:
{
  options = {
    oh-my-posh.enable = lib.mkEnableOption "Enable the oh my posh prompt for the terminal";
  };

  config = {
    oh-my-posh.enable = lib.mkDefault true;

    programs = lib.mkIf config.oh-my-posh.enable {
      oh-my-posh = {
        enable = true;
        enableZshIntegration = true;
        settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./config.json));
      };
    };
  };
}
