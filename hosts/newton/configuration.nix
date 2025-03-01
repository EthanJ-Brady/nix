{pkgs, ...}: {
  custom = {
    enable = true;
    desktop.enable = true;
  };

  users.users.ethanbrady.home = "/Users/ethanbrady";
  networking.hostName = "newton";

  environment.systemPackages = with pkgs; [
    neofetch
  ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
