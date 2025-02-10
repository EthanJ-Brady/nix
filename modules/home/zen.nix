{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.system;
in {
  options = {
    zen.enable = lib.mkEnableOption "Enables the zen browser";
  };

  config = lib.mkIf config.zen.enable {
    home.packages = [
      inputs.zen-browser.packages."${system}".zen
    ];
  };
}
