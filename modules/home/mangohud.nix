{
  config,
  lib,
  ...
}: {
  options = {
    mangohud.enable = lib.mkEnableOption "Enables mangohud for any supported application";
  };

  config = lib.mkIf config.mangohud.enable {
    programs.mangohud = {
      enable = true;
    };
  };
}
