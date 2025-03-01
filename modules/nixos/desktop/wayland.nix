{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    custom.desktop.wayland.enable = lib.mkEnableOption "Enables wayland";
  };

  config = lib.mkIf config.custom.desktop.wayland.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "ethan";
    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];
    environment.sessionVariables.NIXOS_OZONE_WL = lib.mkDefault "1"; # hints to electron and chromium apps to use wayland
  };
}
