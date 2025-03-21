{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.custom.shell.nixvim.enable {
    programs.nixvim.plugins.avante = {
      enable = true;
      settings = {
        provider = "ollama";
        vendors = {
          ollama = {
            __inherited_from = "openai";
            api_key_name = "";
            endpoint = "http://127.0.0.1:11434/v1";
            model = "deepseek-r1";
            disable_tools = true;
          };
        };
      };
    };
  };
}
