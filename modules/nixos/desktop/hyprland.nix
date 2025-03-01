{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    custom.desktop.hyprland.enable = lib.mkEnableOption "Enables the hyprland window tiling manager and it's associated config";
  };

  config = lib.mkIf config.custom.desktop.hyprland.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        intial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "ethan";
        };
        default_session = intial_session;
      };
    };
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
