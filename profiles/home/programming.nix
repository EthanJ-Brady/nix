{ pkgs, config, lib, ... }:
{
  options = {
    profiles.programming = lib.mkEnableOption "Enables programming related tools";
  };

  config = lib.mkIf config.profiles.programming {
    bun.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    lazygit.enable = lib.mkDefault true;

    home.packages = with pkgs; [     
      rustc # Rust compiler
      cargo # Rust package manager
    ];
  };
}
