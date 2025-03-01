{...}: {
  custom = {
    enable = true;
    desktop.enable = true;
  };

  users.users.ethanbrady.home = "/Users/ethanbrady";
  networking.hostName = "newton";
  programs.zsh.enable = true;

  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
