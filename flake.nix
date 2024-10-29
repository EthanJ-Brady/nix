{
  description = "My NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }@inputs:
    let
      configuration =
        { ... }:
        {
          system.configurationRevision = self.rev or self.dirtyRev or null;
        };
    in
    {
      # Minecraft Server
      nixosConfigurations."mohs" = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/mohs/configuration.nix
        ];
      };

      # Macbook Air
      darwinConfigurations."macbook-air" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          ./hosts/macbook-air/configuration.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = [ inputs.nixpkgs-firefox-darwin.overlay ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ethanbrady = import ./hosts/macbook-air/home.nix;
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."macbook-air".pkgs;
    };
}
