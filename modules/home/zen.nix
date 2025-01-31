{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  system = pkgs.system;
  isLinux = pkgs.stdenv.isLinux;
in
{
  options = {
    zen.enable = lib.mkEnableOption "Enables the zen browser";
  };

  config = lib.mkIf config.zen.enable {
    home.packages = lib.mkIf isLinux [
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
