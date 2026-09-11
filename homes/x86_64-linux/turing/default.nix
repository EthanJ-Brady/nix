{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./notification-forwarding.nix
    ./xdg.nix
    inputs.zen-browser.homeModules.default
  ];

  gtk.enable = true;

  home = {
    username = "ethan";
    homeDirectory = "/home/ethan";
    stateVersion = "25.11";

    pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      hyprcursor.enable = true;
      name = "Banana";
      package = pkgs.banana-cursor;
      size = 24;
    };

    packages = with pkgs; [
      archipelago
      bun
      cargo
      celluloid
      discord
      fd
      gcc
      gh
      inputs.barnyard.packages.${pkgs.stdenv.hostPlatform.system}.barnyard
      javaPackages.compiler.temurin-bin.jre-25
      jq
      loupe
      nodejs
      papers
      pkg-config
      pnpm
      rustc
      tlrc
      unzip
      zip
    ];
  };

  my = {
    graphics.enable = true;
    development = {
      enable = true;
      git = {
        email = "turing@itsEthan.dev";
        name = "Ethan Brady";
      };
    };
    terminal.enable = true;
  };

  programs = {
    btop.enable = true;
    direnv = {
      enable = true;
      enableFishIntegration = true;
    };
    fish = {
      shellAliases.pi = "nix develop ~/.config/nix#pi --command pi";
      shellAbbrs.pic = "pi -e npm:@agent-sh/computer-use-linux";
    };
    ghostty = {
      clearDefaultKeybinds = true;
      enable = true;
      enableFishIntegration = true;
      installBatSyntax = true;
      settings = {
        command = lib.getExe config.programs.herdr.package;
        confirm-close-surface = false;
        copy-on-select = true;
        keybind = [
          "super+q=quit"
          "super+n=new_window"
          "ctrl+shift+,=reload_config"
          "shift+insert=paste_from_clipboard"
          "ctrl+insert=copy_to_clipboard"
          "ctrl+shift+-=decrease_font_size:1"
          "ctrl+shift+==increase_font_size:1"
          "ctrl+shift+0=reset_font_size"
        ];
        quick-terminal-position = "center";
        quick-terminal-size = "90%,90%";
        selection-clear-on-copy = true;
        shell-integration = "fish";
        window-padding-color = "extend";
        window-padding-x = 4;
        window-save-state = "always";
      };
    };
    home-manager.enable = true;
    lazygit.enable = true;
    mangohud = {
      enable = true;
      enableSessionWide = true;
      settings = {
        display_server = true;
        fan = true;
        frametime = true;
        gamemode = true;
        gpu_fan = true;
        gpu_temp = true;
        no_display = true;
        ram = true;
        toggle_hud = "Super_L+Control_L+H";
        vram = true;
        wine = true;
      };
    };
    rmpc.enable = true;
    zen-browser = {
      enable = true;
      configPath = "${config.home.homeDirectory}/.zen";
      profiles."Default Profile" = {
        isDefault = true;
        path = "75qjbewr.Default Profile";
      };
    };
  };

  services = {
    easyeffects.enable = true;
    mpd = {
      enable = true;
      extraConfig = ''
        restore_paused "yes"
        audio_output {
          type "pulse"
          name "PipeWire Pulse"
          mixer_type "software"
        }
      '';
    };
    mpdris2.enable = true;
  };

  stylix.targets.zen-browser.profileNames = ["Default Profile"];
}
