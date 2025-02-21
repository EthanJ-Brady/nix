{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    custom.hardware.peripherals.enable = lib.mkEnableOption "Enables configuration for peripherals";
  };

  config = lib.mkIf config.custom.hardware.peripherals.enable {
    environment.systemPackages = with pkgs; [
      solaar
    ];

    hardware.logitech.wireless.enable = true;

    systemd.user.services.solaar = {
      description = "Solaar user service for managing Logitech devices";
      wantedBy = ["default.target"];
      after = ["network.target"];
      serviceConfig = {
        ExecStart = "${pkgs.solaar}/bin/solaar --window=hide";
        Restart = "always";
      };
    };
  };
}
