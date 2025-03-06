{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  options = {
    custom.gaming.enable = lib.mkEnableOption "Enables gaming specific settings such as steam, gamescope, gamemode, and gamepad support";
  };

  config = lib.mkIf config.custom.gaming.enable {
    programs.gamemode.enable = true;
    hardware.uinput.enable = true;
    services.udev.packages = [pkgs.game-devices-udev-rules];

    environment.systemPackages = with pkgs; [
      vkbasalt
    ];

    services.udev.extraRules = ''
      ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="Sony Interactive Entertainment DualSense Edge Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    '';

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    services.pipewire = lib.mkIf config.custom.hardware.audio.enable {
      lowLatency.enable = true;
    };
    security.rtkit.enable = lib.mkIf config.custom.hardware.audio.enable true;
  };
}
