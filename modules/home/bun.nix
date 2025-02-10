{
  config,
  lib,
  ...
}: {
  options = {
    bun.enable = lib.mkEnableOption "Enables bun, a fast JavaScript runtime";
  };

  config = lib.mkIf config.bun.enable {
    programs.bun = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
