{
  config,
  lib,
  pkgs,
  ...
}:
let
  supermaven = pkgs.vimUtils.buildVimPlugin {
    pname = "supermaven";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "supermaven-inc";
      repo = "supermaven-nvim";
      rev = "main";
      sha256 = "1h9h98wsnfhkfdmdxjvr2d4idhrvp4i56pp4q6l0m4d2i0ldcgfp";
    };
  };
in
{
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim.extraPlugins = [
      {
        plugin = supermaven;
        config = "lua require(\"supermaven-nvim\").setup({disable_keymaps = true,disable_inline_completion = true,});";
      }
    ];
  };
}
