{
  config,
  lib,
  ...
}: {
  imports = [
    ./desktop
    ./ssh.nix
  ];

  options = {
    custom.enable = lib.mkEnableOption "Enables the custom configuration for darwin";
  };

  config = lib.mkIf config.custom.enable {
    nix.settings.experimental-features = "nix-command flakes";
  };
}
