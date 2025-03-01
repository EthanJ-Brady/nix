{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    custom.hardware.audio.enable = lib.mkEnableOption "Enables audio configuration for linux";
  };

  config = lib.mkIf config.custom.hardware.audio.enable {
    environment.systemPackages = with pkgs; [
      qpwgraph
      pulsemixer
      easyeffects
    ];

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
