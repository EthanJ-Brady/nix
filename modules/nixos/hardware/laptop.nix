{
  config,
  lib,
  ...
}: {
  options = {
    custom.hardware.laptop.enable = lib.mkEnableOption "Enables laptop specific power and preformance settings";
  };

  config = lib.mkIf config.custom.hardware.laptop.enable {
    services.auto-cpufreq.enable = true;
    services.auto-cpufreq.settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}
