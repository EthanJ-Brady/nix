{ config, lib, ... }:
{
  options = {
    profiles.theme = lib.mkEnableOption "Enables user wide themes";
  };

  config = lib.mkIf config.profiles.theme {
    catppuccin.enable = lib.mkDefault true;
  };
}
