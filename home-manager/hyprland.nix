{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "eDP-1, 1920x1080@60, 0x0, 1"
        ", preferred, auto, 1"
      ];

      input = {
        kb_layout = "us, us";
        kb_variant = ", colemak";
        kb_options = "caps:backspace, grp:alt_shift_toggle";

        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
        sensitivity = 0;
      };

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;

        # col.active_border = rgba($mauve) rgba($teal) rgba($green) rgba($sky) 45deg
        "col.active_border" = "rgba(cba6f780)";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
      };

      decoration = {
        # rounding = 10
        # # Consider as alternative to borders
        # dim_inactive = true;
        # dim_strength = 0.15;
        #
        # blur = {
        #     enabled = true;
        #     size = 3;
        #     passes = 3;
        #     new_optimizations = on;
        # };
        #
        # drop_shadow = true
        # shadow_range = 4
        # shadow_render_power = 3
        # col.shadow = rgba(1a1a1aee)
      };

      animations = {
        enabled = true;
        bezier = [
          "myBezier, 0.00, 1.0, 0.0, 1.00"
        ];

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, myBezier, popin 80%"
          "border, 1, 10, myBezier"
          "borderangle, 1, 8, myBezier"
          "fade, 1, 7, myBezier"
          "workspaces, 1, 6, myBezier"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        animate_manual_resizes = true;
        new_window_takes_over_fullscreen = 2;
      };

      workspace = [
        "2, bordersize:0"
      ];

      windowrulev2 = [
        "float, class:^(Notas)$"
        "size 80% 80%, class:^(Notas)$"
        "center(1), class:^(Notas)$"
      ];

      env = [
        "GTK_THEME,Catppuccin-Mocha-Compact-Mauve-Dark"
        "HYPRCURSOR_THEME,rose-pine-cursor-hyprcursor"
        "HYPRCURSOR_SIZE,32"
        "XCURSOR_SIZE,32"
      ];

      exec-once = [
        "hyprpaper"
        "eww open-many bar connect"
      ];

      "$mainMod" = "SUPER";

      "$notifyVolume" = "pactl get-sink-volume @DEFAULT_SINK@ | rg left | awk -F '/' '{ print $2 }' | tr -d ' %' | xargs -I _ notify-send -t 250 -h string:syncronous:volume -h int:value:_  \"Volume\" && aplay \"$HOME/.local/share/sounds/MDario-theme/tap-notification.wav\"";

      "$notifyBacklight" = "light -G | xargs -I _ notify-send -t 250 -h string:syncronous:volume -h int:value:_  \"Backlight\"";

      bind = [
        # hyprland management
        "$mainMod, C, killactive,"
        "$mainMod, F, fullscreen, 0,"
        "$mainMod SHIFT, F, fullscreen, 1,"
        "$mainMod, J, togglesplit, # dwindle"
        "$mainMod, M, exit"

        # system management
        "$mainMod, right, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%; $notifyVolume"
        "$mainMod, left, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%; $notifyVolume"
        "$mainMod, up, exec, light -A 5; $notifyBacklight"
        "$mainMod, down, exec, light -U 5; $notifyBacklight"
        "$mainMod, R, exec, eww close-all"

        # Main applications
        "$mainMod, Q, exec, kitty"
        "$mainMod, E, exec, nemo"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, F1, exec, firefox"
        "$mainMod, O, exec, fuzzel"
        "$mainMod, S, exec, bemoji"
        "$mainMod, P, exec, grim -g \"$(slurp)\" ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%s_grim.png') # Screenshot"
        "$mainMod, N, exec, kitty --class 'Notas' --hold zsh -c '(cd ~/Documents/Notas; nvim Queue.md)' # Notes"
        "$mainMod, W, exec, lutris lutris:rungameid/2"

        # Move focus 
        "$mainMod, h, cyclenext, prev"
        "$mainMod, k, cyclenext, "
        "$mainMod SHIFT, s, swapactiveworkspaces, current +1"
        "$mainMod, Tab, workspace, e+1"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
