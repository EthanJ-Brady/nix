{
  config,
  lib,
  ...
}: {
  options = {
    custom.desktop.yabai.enable = lib.mkEnableOption "Enables yabai, a tiling window manager for macOS.";
  };

  config = lib.mkIf config.custom.desktop.yabai.enable {
    services.yabai = {
      enable = true;
    };
  };
}
