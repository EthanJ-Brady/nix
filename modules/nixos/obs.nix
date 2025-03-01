{
  config,
  lib,
  ...
}: {
  options = {
    custom.obs.enable = lib.mkEnableOption "Enables OBS Studio";
  };

  config = lib.mkIf config.custom.obs.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
  };
}
