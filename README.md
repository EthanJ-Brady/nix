# Nix Configuration

My personal nix configuration for awesome reproducible and declarative systems.

## Setup

### NixOS

#### Enable Flakes and Git

In `/etc/nixos/configuration.nix`, add the following:

```nix
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
  environment.systemPackages = with pkgs; [
    git
  ];
```

This will allow you to use flakes and git which are required for this confiugration. Once added, run `sudo nixos-rebuild switch` to apply the configuration.

#### Obtain this Configuration

Run `git clone https://github.com/EthanJ-Brady/nix.git` in your home directory to clone this repostiory.`

#### Add a New System

In `flake.nix`, you will need to add a new profile for your system. The exact syntax for this is omitted here, but you should be able to find examples already in the file.

Create a new directory in `hosts/` with the name of your system. Copy both `configuration.nix` and `hardware-configuration.nix` from the `/etc/nixos/` directory on your machine. If `hardware-configuration.nix` is not present, generate it with `nix-generate-config`.

Switch to your new system with `sudo nixos-rebuild switch --flake ~/nix#profile-name` where `profile-name` is the name of the profile you created in the previous step.

## Usage

### Github

TODO

### SSH

TODO

### VPN

TODO
