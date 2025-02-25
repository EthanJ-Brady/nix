{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options = {
    hyprland.enable = lib.mkEnableOption "Enables hyprland user configuration";
  };

  config = lib.mkIf config.hyprland.enable {
    home.file.".config/hypr/toggle_zoom.sh" = {
      source = ./toggle_zoom.sh;
      executable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$appLauncher" = "ALT_SHIFT_CTRL";
        "$mod" = "ALT";
        "$mod_alt" = "ALT_SHIFT";
        "general:gaps_out" = 8;
        "general:gaps_in" = 8;
        "cursor:inactive_timeout" = 3;
        "cursor:no_hardware_cursors" = 1;
        "decoration:rounding" = 8;
        exec-once = [
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
        ];
        bind = [
          # Find clients by looking for `class: <class>` in `hyprctl clients`
          "$appLauncher, B, exec, raise -c \"Brave-browser\" -e \"brave\""
          "$appLauncher, D, exec, raise -c \"vesktop\" -e \"vesktop\""
          "$appLauncher, T, exec, raise -c \"com.mitchellh.ghostty\" -e \"ghostty\""
          "$appLauncher, S, exec, raise -c \"steam\" -e \"steam\""
          "$appLauncher, G, workspace, game"

          "SUPER, Q, killactive"

          "SUPER_SHIFT, C, exec, hyprpicker -a"
          "SUPER_SHIFT, Z, exec, ~/.config/hypr/toggle_zoom.sh"
          "SUPER_SHIFT, 3, exec, hyprshot -m output"
          "SUPER_SHIFT, 4, exec, hyprshot -m region"
          "SUPER_SHIFT, 5, exec, hyprshot -m window"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "$mod_alt, left, movewindow, l"
          "$mod_alt, right, movewindow, r"
          "$mod_alt, up, movewindow, u"
          "$mod_alt, down, movewindow, d"
          "$mod, f, fullscreen, 0"
          "$mod, space, togglespecialworkspace"
          "$mod, m, togglespecialworkspace, mixer"
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, home, workspace, r-1"
          "$mod, end, workspace, r+1"
          "$mod_alt, space, movetoworkspace, special"
          "$mod_alt, 1, movetoworkspace, 1"
          "$mod_alt, 2, movetoworkspace, 2"
          "$mod_alt, 3, movetoworkspace, 3"
          "$mod_alt, 4, movetoworkspace, 4"
          "$mod_alt, 5, movetoworkspace, 5"
          "$mod_alt, 6, movetoworkspace, 6"
          "$mod_alt, 7, movetoworkspace, 7"
          "$mod_alt, 8, movetoworkspace, 8"
          "$mod_alt, home, movetoworkspace, r-1"
          "$mod_alt, end, movetoworkspace, r+1"
          "$mod, l, togglefloating"
          "$mod, p, pin"
          "$mod, c, centerwindow"
        ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        windowrulev2 = [
          "workspace name:game, class:^steam_app_\\d+$"
          "fullscreen, class:^steam_app_\\d+$"
          "allowsinput on, class:^steam_app_\\d+$"

          "stayfocused, title:pulsemixer"
          "float, title:pulsemixer"
          "pin, title:pulsemixer"
          "size 37.5% 37.5%, title:pulsemixer"
          "move 100%-w-8 48, title:pulsemixer"
        ];
        workspace = [
          "name:game, monitor:HDMI-A-1, default:true"
          "special:special, on-created-empty:ghostty"
        ];
      };
    };

    services.cliphist.enable = true;

    home.packages = with pkgs; [
      hyprpicker
      hyprshot
      hyprsunset
      inputs.raise.defaultPackage.x86_64-linux
    ];
  };
}
