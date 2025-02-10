{
  config,
  lib,
  ...
}: {
  options = {
    lazygit.enable = lib.mkEnableOption "Enables lazygit and it's settings";
  };

  config = lib.mkIf config.lazygit.enable {
    programs.lazygit = {
      enable = true;
    };
  };
}
