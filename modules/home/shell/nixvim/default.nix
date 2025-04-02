{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./opts.nix
    ./keymaps.nix
    ./autocmds.nix
    ./plugins
  ];

  options = {
    custom.shell.nixvim.enable = lib.mkEnableOption "Enables the neovim distribution nixvim";
    custom.shell.nixvim.ai-codewriter = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "A string representing the AI codewriter to use in nixvim";
      default = null;
    };
  };

  config = lib.mkIf config.custom.shell.nixvim.enable {
    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    custom.shell.nixvim.ai-codewriter = lib.mkDefault "supermaven";
    programs.nixvim = {
      enable = true;
      globals.mapleader = " ";
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    home.file.".config/nvim/snippets" = {
      source = ./snippets;
      recursive = true;
    };
  };
}
