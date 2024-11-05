{ config, lib, ... }:
{
  options = {
    profiles.apps = lib.mkEnableOption "Enables basic system apps";
  };

  config = lib.mkIf config.profiles.apps {
    firefox.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
  };
}
