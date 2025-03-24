{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.custom.shell.nixvim.enable {
    programs.nixvim.plugins.gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        signs = {
          add.text = "+";
          change.text = "~";
          delete.text = "_";
          topdelete.text = "‾";
          changedelete.text = "~";
        };
      };
    };
  };
}
