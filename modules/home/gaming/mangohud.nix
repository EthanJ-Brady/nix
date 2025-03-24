{
  config,
  lib,
  ...
}: {
  options = {
    custom.gaming.mangohud.enable = lib.mkEnableOption "Enables mangohud full configuration";
  };

  config = lib.mkIf config.custom.gaming.mangohud.enable {
    programs.mangohud = {
      enable = true;
      settings.full = true;
    };
  };
}
