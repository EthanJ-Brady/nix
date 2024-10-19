{
  description = "My NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nixvim,
    }:
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
      darwinConfigurations."newton" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/newton/configuration.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = [ inputs.nixpkgs-firefox-darwin.overlay ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ethanbrady =
              { ... }:
              {
                imports = [
                  ./hosts/macbook-air/home.nix
                  nixvim.homeManagerModules.nixvim
                ];
              };
          }
        ];
      };
    };
}
