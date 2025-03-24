{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.custom.shell.nixvim.enable {
    programs.nixvim.autoCmd = [
      {
        event = "TextYankPost";
        desc = "Highlight when yanking text";
        command = "lua vim.highlight.on_yank()";
      }
    ];
  };
}
