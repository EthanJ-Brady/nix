{...}: {
  custom = {
    enable = true;
    desktop.enable = true;
  };

  users.users.ethanbrady.home = "/Users/ethanbrady";

  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.hostName = "newton";
}
