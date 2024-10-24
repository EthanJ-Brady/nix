{ config, lib, ... }:
{
  options = {
    lazygit.enable = lib.mkEnableOption "Enables lazygit and it's settings";
  };

  config = {
    lazygit.enable = lib.mkDefault true;

    programs.lazygit = lib.mkIf config.lazygit.enable {
      enable = true;
    };
  };
}
