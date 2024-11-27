{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim.plugins.which-key = {
      enable = true;
      settings = {
        spec = [
          { __unkeyed-1 = "<leader>c"; group = "[C]ode"; mode = [ "n" "x" ]; }
          { __unkeyed-2 = "<leader>d"; group = "[D]ocument"; }
          { __unkeyed-3 = "<leader>r"; group = "[R]ename"; }
          { __unkeyed-4 = "<leader>s"; group = "[S]earch"; }
          { __unkeyed-5 = "<leader>w"; group = "[W]orkspace"; }
          { __unkeyed-6 = "<leader>t"; group = "[T]oggle"; }
          { __unkeyed-7 = "<leader>h"; group = "Git [H]unk"; mode = [ "n" "v" ]; }
        ];
      };
    };
  };
}
