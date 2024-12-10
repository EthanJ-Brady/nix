{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.nixvim.enable {
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
