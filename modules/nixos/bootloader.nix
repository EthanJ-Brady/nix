{
  config,
  lib,
  ...
}: {
  options = {
    bootloader.enable = lib.mkEnableOption "Enables boot configuration settings with grub";
  };

  config = lib.mkIf config.bootloader.enable {
    boot = {
      plymouth = {
        enable = true;
      };

      # Enable "Silent Boot"
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "plymouth.force-splash=1"
        "plymouth.device=all"
      ];

      loader = {
        efi.canTouchEfiVariables = true;
        timeout = 0;

        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          useOSProber = true;
          configurationLimit = 10;
        };
      };
    };
  };
}
