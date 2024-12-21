{ config, lib, pkgs, ... }:
{
  options = {
    logitech.enable = lib.mkEnableOpiton "Enables logitech universal receiver and customization tools";
  };

  config = lib.mkIf config.logitech.enable {
    environment.systemPackages = with pkgs; [
      solaar
    ];

    hardware.logitech.wireless.enable = true;

    systemd.user.services.solaar = {
      description = "Solaar user service for managing Logitech devices";
      wantedBy = [ "default.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.solaar}/bin/solaar --window=hide";
        Restart = "always";
      };
    };
  };
}
