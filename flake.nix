{
  description = "My NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
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
      ...
    }@inputs: {
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
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = [ inputs.nixpkgs-firefox-darwin.overlay ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.ethanbrady = {
              imports = [
                ./hosts/newton/home.nix
                ./modules/home
                ./profiles/home
              ];
            };
          }
        ];
      };
    };
}
