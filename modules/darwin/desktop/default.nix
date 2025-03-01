{
  config,
  lib,
  ...
}: {
  imports = [
    ./jankyborders.nix
    ./sketchybar.nix
    ./skhd.nix
    ./yabai.nix
  ];

  options = {
    custom.desktop.enable = lib.mkEnableOption "Enables the custom desktop configuration for darwin";
  };

  config = lib.mkIf config.custom.desktop.enable {
    custom.desktop = {
      jankyborders.enable = lib.mkDefault true;
      sketchybar.enable = lib.mkDefault true;
      skhd.enable = lib.mkDefault true;
      yabai.enable = lib.mkDefault true;
    };
  };
}
