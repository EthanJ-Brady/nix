{
  config,
  lib,
  ...
}: {
  options = {
    zellij.enable = lib.mkEnableOption "Enables the terminal workspace zellij and its config";
  };

  config = lib.mkIf config.zellij.enable {
    home.file.".config/zellij/config.kdl" = {
      text = builtins.readFile ./config.kdl;
    };

    programs.zellij = {
      enable = true;
      enableZshIntegration = lib.mkIf config.zsh.enable true;
    };
  };
}
