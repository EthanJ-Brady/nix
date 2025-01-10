{
  config,
  lib,
  ...
}:
{
  options = {
    pipewire.enable = lib.mkEnableOption "Enables pipewire and associated settings";
  };

  config = lib.mkIf config.pipewire.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
