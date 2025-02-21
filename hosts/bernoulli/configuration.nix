{pkgs, ...}: {
  bootloader.enable = true;
  hyprland.enable = true;
  gaming.enable = true;
  logitech.enable = true;
  nvidia.enable = true;
  pipewire.enable = true;
  ssh = {
    enable = true;
    username = "ethan";
  };

  security.sudo.wheelNeedsPassword = false;

  hardware.keyboard.zsa.enable = true;

  services.blueman.enable = true;

  networking.hostName = "bernoulli";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  services.printing.enable = true;
  hardware.bluetooth.enable = true;

  programs.zsh.enable = true;

  services.openssh.enable = true;

  users.users.ethan = {
    isNormalUser = true;
    description = "Ethan Brady";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  virtualisation.docker.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ethan";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.system = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    firefox
    # gnome-disk-utility
    # pciutils
    wl-clipboard
    vivaldi
    libgccjit # reqiured for nvim
    nodejs_23 # required for nvim
    binutils # required for nvim
    gcc_multi # required for nvim
    ripgrep # required for nvim
    fd # required for nvim
    cargo
    gparted
    brave
    # gnome-usage
    # dotnet-sdk_8
    # wl-color-picker
    home-manager
    # appimage-run
    # pavucontrol
    # melonDS
    # nh
    kitty
    # easyeffects
  ];

  environment.sessionVariables.FLAKE = "/home/ethan/Dotfiles/nix";

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  fileSystems."/run/media/ethan/Games" = {
    device = "/dev/nvme0n1p6";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
