{
  config,
  lib,
  ...
}:
{
  options = {
    steam.enable = lib.mkEnableOption "Enables steam and opens the associated ports/firewalls";
  };

  config = lib.mkIf config.steam.enable {
    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}
