{
  config,
  lib,
  ...
}:
{
  options = {
    laptop.enable = lib.mkEnableOption "Enables laptop specific power and preformance settings";
  };

  config = lib.mkIf config.laptop.enable {
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
