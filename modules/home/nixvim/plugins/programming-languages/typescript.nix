{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim.plugins = {
      lsp.servers.ts_ls.enable = false;
      typescript-tools.enable = true;
    };
  };
}
