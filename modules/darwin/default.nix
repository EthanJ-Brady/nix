{lib, ...}: {
  imports = [
    ./desktop
    ./ssh.nix
  ];

  options = {
    custom.enable = lib.mkEnableOption "Enables the custom configuration for darwin";
  };
}
