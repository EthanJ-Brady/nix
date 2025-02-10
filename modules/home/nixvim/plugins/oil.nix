{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      plugins.oil = {
        enable = true;
        settings = {
          columns = ["icon"];
          keymaps = {
            "<C-h>" = false;
            "<M-h>" = "actions.select_split";
          };
          view_options.show_hidden = true;
        };
      };

      keymaps = [
        {
          action = "<CMD>Oil<CR>";
          options.desc = "Open parent directory";
          key = "-";
          mode = "n";
        }
        {
          action = "<CMD>lua require('oil').toggle_float()<CR>";
          options.desc = "Open oil in a floating window";
          key = "<leader>-";
          mode = "n";
        }
      ];
    };
  };
}
