{
  config,
  lib,
  ...
}: {
  imports = [
    ./desktop
    ./network
    ./system.nix
  ];

  options = {
    custom.enable = lib.mkEnableOption "Enables the custom configuration for darwin";
  };

  config = lib.mkIf config.custom.enable {
    custom = {
      network.enable = lib.mkDefault true;
      system.enable = lib.mkDefault true;
    };

    nix.settings.experimental-features = "nix-command flakes";
  };
}
