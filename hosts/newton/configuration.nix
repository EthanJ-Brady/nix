{ pkgs, ... }:

{
  yabai.enable = true;
  sketchybar.enable = true;
  skhd.enable = true;
  jankyborders.enable = true;

  users.users.ethanbrady.home = "/Users/ethanbrady";

  environment.systemPackages = with pkgs; [
    neofetch
    nixd # Nix LSP
    nixfmt-rfc-style # Nix formatter
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    noto-fonts
    noto-fonts-monochrome-emoji
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Allow sudo commands to be run with biometrics
  security.pam.enableSudoTouchIdAuth = true;

  # Set mouse tracking speed
  system.defaults.".GlobalPreferences"."com.apple.mouse.scaling" = 1.0;
  # Set the dock to automatically hide
  system.defaults.dock.autohide = true;
  # Don't rearrange spaces based on most recently used
  system.defaults.dock.mru-spaces = false;
  # Set the dock to not show recent applications
  system.defaults.dock.show-recents = false;
  # Show all file extensions
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  # Set the default finder view style to column view
  system.defaults.finder.FXPreferredViewStyle = "clmv";
  # Set login window text
  system.defaults.loginwindow.LoginwindowText = "Hello, Ethan!";
  # Disable back and forward two finger swipe gestures on the mouse
  system.defaults.NSGlobalDomain.AppleEnableMouseSwipeNavigateWithScrolls = false;
  # Disable back and forward two finger swipe gestures on the trackpad
  system.defaults.NSGlobalDomain.AppleEnableSwipeNavigateWithScrolls = false;
  # Enable metric units
  system.defaults.NSGlobalDomain.AppleMetricUnits = 1;
  # Set Fn keys to default to F1, F2, etc.
  system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;
  # Turn natural scrolling off
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  # Sets the trackpad speec
  system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 2.5;
  # Automatically install macOS updates
  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
  # Allow quiting finder
  system.defaults.finder.QuitMenuItem = true;
  # Show breadcrumbs in finder
  system.defaults.finder.ShowPathbar = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
