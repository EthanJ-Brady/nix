{
  config,
  lib,
  ...
}: {
  imports = [
    ./catppuccin
    ./desktop
    ./gaming
    ./shell
    ./ssh.nix
  ];

  options = {
    custom.enable = lib.mkEnableOption "Enables custom configuration";
  };

  config = lib.mkIf config.custom.enable {
    custom.shell.enable = lib.mkDefault true;
    custom.ssh.enable = lib.mkDefault true;
  };
}
