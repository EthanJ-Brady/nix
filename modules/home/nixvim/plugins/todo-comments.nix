{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim.plugins.todo-comments = {
      enable = true;
      settings.signs = false;
    };
  };
}
