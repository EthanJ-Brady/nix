{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.custom.shell.nixvim.enable {
    programs.nixvim.plugins.noice = {
      enable = true;
      settings = {
        cmdline.opts.border.style = "none";
      };
    };
  };
}
