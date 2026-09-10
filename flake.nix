{
  description = "It's Ethan's configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    barnyard = {
      url = "github:ItsEthanDev/barnyard-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mandelbrust = {
      url = "github:ItsEthanDev/mandelbrust";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zapp.url = "github:zsa/zapp";
  };

  outputs = {
    self,
    home-manager,
    nix-darwin,
    nixpkgs,
    ...
  } @ inputs: let
    pkgsFor = system:
      import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
      };
  in {
    lib = import ./lib {
      inherit (nixpkgs) lib;
    };

    nixosModules = import ./modules/nixos;

    darwinModules = import ./modules/darwin;

    homeManagerModules = import ./modules/home;

    overlays = import ./overlays {
      inherit (nixpkgs) lib;
    };

    packages =
      nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
      ] (
        system:
          import ./packages {
            pkgs = pkgsFor system;
          }
      );

    checks.x86_64-linux = let
      pkgs = pkgsFor "x86_64-linux";
    in {
      bun = pkgs.runCommand "bun-version" {nativeBuildInputs = [pkgs.bun];} ''
        [[ "$(bun --version)" == "1.4.0" ]]
        touch "$out"
      '';

      documentation = import ./checks/documentation.nix {inherit pkgs;};

      neovim = import ./checks/neovim.nix {
        inherit pkgs;
        inherit (self.nixosConfigurations.turing.config.home-manager.users.ethan.programs.nixvim.build) initFile extraFiles;
        neovim = self.nixosConfigurations.turing.config.home-manager.users.ethan.programs.nixvim.build.package;
      };

      module-contracts = import ./checks {
        inherit home-manager inputs nixpkgs pkgs;
        darwinModules = self.darwinModules;
        homeManagerModules = self.homeManagerModules;
        nixosModules = self.nixosModules;
      };
    };

    devShells = self.lib.forAllSystems (
      system:
        import ./shells {
          pkgs = pkgsFor system;
        }
    );

    darwinConfigurations = {
      newton = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          {nixpkgs.overlays = [self.overlays.default];}
          self.darwinModules.default
          ./systems/aarch64-darwin/newton
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
              users.ethan = {
                imports = [
                  self.homeManagerModules.default
                  ./homes/aarch64-darwin/newton
                ];
              };
            };
          }
        ];
      };
    };

    nixosConfigurations = {
      turing = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          {nixpkgs.overlays = [self.overlays.default];}
          self.nixosModules.default
          ./systems/x86_64-linux/turing
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
              users.ethan = {
                imports = [
                  self.homeManagerModules.default
                  ./homes/x86_64-linux/turing
                ];
              };
            };
          }
        ];
      };
    };
  };
}
