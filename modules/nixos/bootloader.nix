{
  config,
  lib,
  ...
}:
{
  options = {
    bootloader.enable = lib.mkEnableOption "Enables boot configuration settings with grub";
  };

  config = lib.mkIf config.bootloader.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        configurationLimit = 10;
      };
    };
  };
}
