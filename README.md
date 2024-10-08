# Nix Configuration

## Setup

### MacOS

[Nix Darwin Githug Repo](https://github.com/LnL7/nix-darwin/blob/master/README.md)

1. Install Nix

Find instructions [here](https://nix.dev/install-nix). As of writing this, the command is:

```sh
curl -L https://nixos.org/nix/install | sh
```

2. Install Nix Darwin

Find instructions [here](https://github.com/LnL7/nix-darwin/blob/master/README.md#step-2-installing-nix-darwin). As of writing this, the command is:

```sh
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/path/to/flake.nix#<profile>
```

The path to the `flake.nix` file depends on where you have it stored on your machine. The profile is the name of the profile defined in the `flake.nix` file. For example, if this is profile you want to use with the flake:

```nix
darwinConfigurations."macbook-air" = nix-darwin.lib.darwinSystem {
  modules = [ configuration ];
};
```

Then the profile is `macbook-air`.

3. Using Nix Darwin

Find instructions [here](https://github.com/LnL7/nix-darwin/blob/master/README.md#step-3-using-nix-darwin). As of writing this, the command to apply the configuration is:

```sh
darwin-rebuild switch --flake ~/path/to/flake/directory#<profile>
```

## Search

To search for packages from `nixpkgs`, use the following command:

```sh
nix search nixpkgs <package-name>
```

You can also use the web interface [here](https://search.nixos.org/packages).
