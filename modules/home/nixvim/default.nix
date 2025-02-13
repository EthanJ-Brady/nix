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
    nixvim.enable = lib.mkEnableOption "Enables the neovim distribution nixvim";
    nixvim.ai-codewriter = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "A string representing the AI codewriter to use in nixvim";
      default = null;
    };
  };

  config = lib.mkIf config.nixvim.enable {
    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
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
