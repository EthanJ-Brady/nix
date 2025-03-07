{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    custom.gaming.games.nethack.enable = lib.mkEnableOption "Enables the nethack game";
  };

  config = lib.mkIf config.custom.gaming.games.nethack.enable {
    home.packages = with pkgs; [
      nethack
    ];
    home.file.".nethackrc".text = ''
      OPTIONS=windowtype:curses
      OPTIONS=fullscreen:true
      OPTIONS=perm_invent:true
      OPTIONS=align_status:right
      OPTIONS=align_message:bottom
    '';
  };
}
