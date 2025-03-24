{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.custom.shell.nixvim.enable {
    programs.nixvim.plugins.todo-comments = {
      enable = true;
      settings.signs = false;
    };
  };
}
