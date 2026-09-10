{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.development;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.plugins = {
      lsp = {
        enable = lib.mkDefault true;
        servers = {
          # CSS
          cssls.enable = lib.mkDefault true;
          # Nix
          nixd = {
            enable = lib.mkDefault true;
            settings = {
              nixpkgs.expr = lib.mkDefault "import ${pkgs.path} { }";
            };
          };
          # Rust
          rust_analyzer = {
            enable = lib.mkDefault true;
            installRustc = lib.mkDefault false;
            installCargo = lib.mkDefault false;
            settings = {
              cargo = {
                targetDir = lib.mkDefault "target/rust-analyzer";
              };
            };
          };
          # Tailwind
          tailwindcss.enable = lib.mkDefault true;
          # Typescript
          tsgo = {
            enable = lib.mkDefault true;
            package = lib.mkDefault pkgs.typescript;
            cmd = lib.mkDefault [(lib.getExe pkgs.typescript) "--lsp" "--stdio"];
          };
        };
      };
    };
  };
}
