{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    custom.user.enable = lib.mkEnableOption "Setups the user account for the system";
    custom.user.username = lib.mkOption {
      type = lib.types.str;
      default = "ethan";
      description = "The username for the user account";
    };
  };

  config = lib.mkIf config.custom.user.enable {
    programs.zsh.enable = lib.mkDefault true;
    users.users."${config.custom.user.username}" = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.zsh;
    };
  };
}
