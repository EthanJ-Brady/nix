{
  pkgs,
  config,
  lib,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  ghostty-mock = pkgs.writeShellScriptBin "ghostty-mock" "";
in
{
  options = {
    ghostty.enable = lib.mkEnableOption "Enables the terminal emulator ghostty and the configuration";
  };

  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;
      package = lib.mkIf isDarwin ghostty-mock;
      settings = {
        font-size = 16;
        macos-titlebar-style = "hidden";
        window-decoration = "auto";
        window-padding-x = 8;
        window-padding-y = 8;
        background-opacity = 0.9;
        background-blur-radius = 32;
      };
    };
  };
}
