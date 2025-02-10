{
  config,
  lib,
  ...
}: {
  options = {
    gamescope.enable = lib.mkEnableOption "Enables the gamescope microcompistor for gaming";
  };

  config = lib.mkIf config.gamescope.enable {
    programs = {
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      steam.gamescopeSession.enable = true;
    };
  };
}
