{
  config,
  lib,
  ...
}: {
  options = {
    custom.system.enable = lib.mkEnableOption "Enables preffered system settings for MacOS";
  };

  config = lib.mkIf config.custom.system.enable {
    # Allow sudo commands to be run with biometrics
    security.pam.services.sudo_local.touchIdAuth = true;
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
  };
}
