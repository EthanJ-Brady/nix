{
  config,
  lib,
  ...
}:
{
  imports = [];

  config = lib.mkIf config.nixvim.enable {
    programs.nixvim.plugins = {
      sleuth.enable = true;
    };
  };
}
