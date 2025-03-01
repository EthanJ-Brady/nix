{...}: {
  custom = {
    enable = true;
    desktop.enable = true;
  };

  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.hostName = "newton";
}
