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
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    raise.url = "github:knarkzel/raise";
    zen-browser.url = "github:EthanJ-Brady/zen-browser-flake";
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  } @ inputs: {
    # Zephyr Laptop
    nixosConfigurations."bernoulli" = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/bernoulli/configuration.nix
        ./hosts/bernoulli/hardware-configuration.nix
        ./modules/nixos
        inputs.nixos-hardware.nixosModules.asus-zephyrus-ga502
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          home-manager.users.ethan = {
            imports = [
              ./hosts/bernoulli/home.nix
              ./modules/home
            ];
          };
        }
      ];
    };

    # Digital Ocean Server
    nixosConfigurations."morse" = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/morse/configuration.nix
        ./hosts/morse/hardware-configuration.nix
        # ./modules/nixos
        # home-manager.nixosModules.home-manager
        # {
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.useUserPackages = true;
        #   home-manager.extraSpecialArgs = {
        #     inherit inputs;
        #   };
        #   home-manager.users.ethan = {
        #     imports = [
        #       ./hosts/morse/home.nix
        #       ./modules/home
        #     ];
        #   };
        # }
      ];
    };

    # Minecraft Server
    nixosConfigurations."mohs" = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/mohs/configuration.nix
        ./hosts/mohs/hardware-configuration.nix
      ];
    };

    # Macbook Air
    darwinConfigurations."newton" = nix-darwin.lib.darwinSystem {
      modules = [
        ./hosts/newton/configuration.nix
        ./modules/darwin
        home-manager.darwinModules.home-manager
        {
          nixpkgs.overlays = [inputs.nixpkgs-firefox-darwin.overlay];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          home-manager.users.ethanbrady = {
            imports = [
              ./hosts/newton/home.nix
              ./modules/home
            ];
          };
        }
      ];
    };
  };
}
