{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.development;
  tsgo = config.programs.nixvim.plugins.lsp.servers.tsgo;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.extraFiles."lua/typescript-command.lua".source = ./typescript-command.lua;
    programs.nixvim.lsp.servers.tsgo.config = {
      root_dir = lib.mkDefault {
        __raw = ''require("typescript-command")(nil).root_dir'';
      };
      cmd = lib.mkIf (tsgo.cmd == null) (lib.mkDefault {
        __raw = ''
          require("typescript-command")(${
            if tsgo.package == null
            then "nil"
            else builtins.toJSON (lib.getExe tsgo.package)
          }).cmd
        '';
      });
    };
    programs.nixvim.plugins = {
      lsp = {
        enable = lib.mkDefault true;
        servers = {
          # CSS
          cssls = {
            enable = lib.mkDefault true;
            packageFallback = lib.mkDefault true;
          };
          # Nix
          nixd = {
            enable = lib.mkDefault true;
            packageFallback = lib.mkDefault true;
            settings = {
              nixpkgs.expr = lib.mkDefault "import ${pkgs.path} { }";
            };
          };
          # Rust
          rust_analyzer = {
            enable = lib.mkDefault true;
            packageFallback = lib.mkDefault true;
            installRustc = lib.mkDefault false;
            installCargo = lib.mkDefault false;
            settings = {
              cargo = {
                targetDir = lib.mkDefault "target/rust-analyzer";
              };
            };
          };
          # Tailwind
          tailwindcss = {
            enable = lib.mkDefault true;
            packageFallback = lib.mkDefault true;
          };
          # Typescript
          tsgo = {
            enable = lib.mkDefault true;
            package = lib.mkDefault pkgs.typescript;
            packageFallback = lib.mkDefault true;
            cmd = lib.mkDefault null;
          };
        };
      };
    };
  };
}
