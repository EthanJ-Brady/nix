{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    gamepads.enable = lib.mkEnableOption "Enables gamepad specific settings";
  };

  config = lib.mkIf config.gamepads.enable {
    services.udev.packages = [ pkgs.game-devices-udev-rules ];
    hardware.uinput.enable = true; 

    services.udev.extraRules = ''
        ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
        ATTRS{name}=="Sony Interactive Entertainment DualSense Edge Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
        ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    '';
  };
}
