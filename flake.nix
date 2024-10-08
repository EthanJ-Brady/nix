{
  description = "Darwin System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      system.configurationRevision = self.rev or self.dirtyRev or null;
    };
  in
  {
    darwinConfigurations."macbook-air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        ./hosts/macbook-air/configuration.nix
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macbook-air".pkgs;
  };
}
