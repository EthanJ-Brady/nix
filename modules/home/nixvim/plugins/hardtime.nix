{
  config,
  lib,
  ...
}:
{
  options = {
    nixvim.plugins.hardtime.enable = lib.mkEnableOption "Enables the nixvim hardtime plugin";
  };

  config = lib.mkIf (config.nixvim.enable && config.nixvim.plugins.hardtime.enable) {
    programs.nixvim.plugins.hardtime = {
      enable = true;
      settings = {
        disabled_keys = {
          "<Up>".__raw = "{}";
          "<Down>".__raw = "{}";
          "<Left>".__raw = "{}";
          "<Right>".__raw = "{}";
        };
        restricted_keys = {
          "<Up>" = [ "n" "x" ];
          "<Down>" = [ "n" "x" ];
          "<Left>" = [ "n" "x" ];
          "<Right>" = [ "n" "x" ];
        };
      };
    };
  };
}
