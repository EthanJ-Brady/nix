{
  config,
  lib,
  ...
}:
{
  options = {
    virtualbox.enable = lib.mkEnableOption "Enables virtualbox and configuration";
  };

  config = lib.mkIf config.virtualbox.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "ethan" ];
  };
}
