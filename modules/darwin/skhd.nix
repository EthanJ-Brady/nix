{ config, lib, ... }:
{
  options = {
    skhd.enable = lib.mkEnableOption "Enables skhd, a simple hotkey daemon for macOS.";
  };

  config = {
    skhd.enable = lib.mkDefault true;

    services.skhd = lib.mkIf config.skhd.enable {
      enable = true;
      skhdConfig = ''
        # Launching applications
        alt + shift + ctrl - b : open -a arc
        alt + shift + ctrl - c : open -a zed
        alt + shift + ctrl - d : open -a discord
        alt + shift + ctrl - f : open -a finder
        alt + shift + ctrl - i : open -a messages
        alt + shift + ctrl - m : open -a mail
        alt + shift + ctrl - n : open -a obsidian
        alt + shift + ctrl - r : open -a reminders
        alt + shift + ctrl - s : open -a stickies
        alt + shift + ctrl - t : open -a kitty

        # Navigation
        alt - left : yabai -m window --focus west
        alt - down : yabai -m window --focus south
        alt - up : yabai -m window --focus north
        alt - right : yabai -m window --focus east

        # Moving windows
        shift + alt - left : yabai -m window --warp west
        shift + alt - down : yabai -m window --warp south
        shift + alt - up : yabai -m window --warp north
        shift + alt - right : yabai -m window --warp east

        # Make window native fullscreen
        alt - f : yabai -m window --toggle zoom-fullscreen

        # Move window to space
        shift + alt - 1 : yabai -m window --space 1;
        shift + alt - 2 : yabai -m window --space 2;
        shift + alt - 3 : yabai -m window --space 3;
        shift + alt - 4 : yabai -m window --space 4;
        shift + alt - 5 : yabai -m window --space 5;
        shift + alt - 6 : yabai -m window --space 6;
        shift + alt - 7 : yabai -m window --space 7;
      '';
    };
  };
}
