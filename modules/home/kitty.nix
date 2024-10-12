{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    kitty.enable = lib.mkEnableOption "Enables kitty terminal emulator";
  };

  config = {
    kitty.enable = lib.mkDefault true;

    programs.kitty = lib.mkIf config.kitty.enable {
      enable = true;
      font = {
        name = "FiraCode Nerd Font";
        package = pkgs.fira-code-nerdfont;
      };
      themeFile = "OneDark";
    };
  };
}
