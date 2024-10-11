{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neofetch
    bat
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Allow sudo commands to be run with biometrics
  security.pam.enableSudoTouchIdAuth = true;

  # Disable mouse acceleration
  system.defaults.".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;

  # Set the dock to automatically hide
  system.defaults.dock.autohide = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
