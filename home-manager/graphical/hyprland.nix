{ config, pkgs, ... }:

let
  hyprsunset-auto = (pkgs.writeShellScriptBin "hyprsunset-auto" ''
    # Configuration
    SUNRISE_TIME="06:00" # Sunrise time
    SUNSET_TIME="18:00"  # Sunset time
    DEFAULT_TEMP=6000  # Default temperature (daylight)
    NIGHT_TEMP=3700      # Temperature at midnight
    GRADUAL_INTERVAL=300  # Interval for gradual changes (in seconds)

    # Function to convert time to minutes since midnight
    time_to_minutes() {
        IFS=: read -r hour minute <<<"$1"
        echo $((hour * 60 + minute))
    }

    # Function to calculate temperature based on time
    calculate_temp() {
        local current_minutes=$(time_to_minutes "$1")
        local sunrise_minutes=$(time_to_minutes "$SUNRISE_TIME")
        local sunset_minutes=$(time_to_minutes "$SUNSET_TIME")
        local night_minutes=$((1440 - sunset_minutes + sunrise_minutes)) # Total night duration in minutes

        if ((current_minutes >= sunrise_minutes && current_minutes < sunset_minutes)); then
            echo $DEFAULT_TEMP
        else
            if ((current_minutes < sunrise_minutes)); then
                current_minutes=$((current_minutes + 1440))
            fi
            elapsed_night_minutes=$((current_minutes - sunset_minutes))
            progress=$((elapsed_night_minutes * 1000 / night_minutes))
            temp=$((DEFAULT_TEMP - (DEFAULT_TEMP - NIGHT_TEMP) * progress / 1000))
            echo $temp
        fi
    }

    # Main loop
    while true; do
        current_time=$(date +"%H:%M")
        temperature=$(calculate_temp "$current_time")
        (pkill -xf hyprsunset || exit 0) && hyprsunset -t "$temperature" &
        sleep GRADUAL_INTERVAL # Sleep for the gradual interval
    done
  '');
in
{
  home.packages = [
    hyprsunset-auto
  ];
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 600;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        ", preferred, auto, 1"
      ];

      input = {
        kb_layout = "us, us";
        kb_variant = ", colemak";
        kb_options = "caps:backspace, grp:alt_shift_toggle";
        numlock_by_default = true;

        repeat_rate = 60;
        repeat_delay = 300;

        sensitivity = 1;
        accel_profile = "flat";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };
      };

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;

        # col.active_border = rgba($mauve) rgba($teal) rgba($green) rgba($sky) 45deg
        "col.active_border" = "rgba(cba6f7ff)";
        "col.inactive_border" = "rgba(595959ff)";

        layout = "dwindle";
      };

      decoration = {
        # rounding = 10
        # # Consider as alternative to borders
        # dim_inactive = true;
        # dim_strength = 0.15;
        #
        blur = {
          enabled = false;
          # size = 3;
          # passes = 3;
          # new_optimizations = "on";
        };
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
          "windowsIn, 1, 5, myBezier"
          "windowsOut, 0"
          "windowsMove, 0"
          "fade, 0"
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

      windowrulev2 = [
        "float, class:^(Notas)$"
        "size 80% 80%, class:^(Notas)$"
        "center(1), class:^(Notas)$"

        "float, class:^.blueman-manager-wrapped$"
        "size 80% 80%, class:^.blueman-manager-wrapped$"

        "float, class:^org.pulseaudio.pavucontrol$"
        "size 80% 80%, class:^org.pulseaudio.pavucontrol$"

        "workspace 1 silent, class:^zen-beta$"
        "workspace 9 silent, class:^discord$"
        "workspace 10 silent, class:^org.telegram.desktop$"
      ];

      env = [
        "GTK_THEME,${config.gtk.theme.name}"
        "HYPRCURSOR_THEME,rose-pine-cursor-hyprcursor"
        "HYPRCURSOR_SIZE,32"
        "XCURSOR_SIZE,32"
        "PATH,$PATH:${config.home.homeDirectory}/.local/bin"
      ];

      exec-once = [
        "hyprpaper &"
        "hyprsunset-auto &"
        "eww open bar&"
        "pactl upload-sample ${config.home.homeDirectory}/.local/share/sounds/MDario-theme/tap-notification.wav &"

        "zen &"
        "telegram-desktop &"
        "discord &"
      ];

      "$mainMod" = "SUPER";

      "$current-volume" = "pactl get-sink-volume @DEFAULT_SINK@ | rg left | awk -F '/' '{ print $2 }' | tr -d ' %'";
      "$notifyVolume" = "$current-volume | xargs -I _ notify-send -t 250 -h string:syncronous:volume -h int:value:_  \"Volume\" && pactl play-sample tap-notification";

      "$notifyBacklight" = "light -G | xargs -I _ notify-send -t 250 -h string:syncronous:volume -h int:value:_  \"Backlight\"";

      bind = [
        # hyprland management
        "$mainMod, C, killactive,"
        "$mainMod, F, fullscreen, 0,"
        "$mainMod SHIFT, F, togglefloating, active"
        "$mainMod, J, togglesplit, # dwindle"
        "$mainMod, M, exit"

        # Main applications
        "$mainMod, Q, exec, kitty"
        "$mainMod, E, exec, nemo"
        "$mainMod SHIFT, L, exec, hyprlock"
        "$mainMod, F1, exec, firefox"
        "$mainMod, O, exec, fuzzel"
        "$mainMod, S, exec, bemoji -n"
        "$mainMod, P, exec, hdrop pinta"
        ", Print, exec, grimblast --notify copysave screen ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%s_grim.png')"
        "SHIFT, Print, exec, grimblast --notify copysave area ${config.xdg.userDirs.pictures}/Screenshots/$(date +'%s_grim.png')"
        "$mainMod, N, exec, kitty --class 'Notas' --hold zsh -c '(cd ~/Documents/Notas; nvim Queue.md)'" # Notes
        "$mainMod, V, exec, hdrop pavucontrol"
        "$mainMod, B, exec, hdrop blueman-manager"
        "$mainMod, W, exec, lutris lutris:rungameid/2"
        # Download video in the clipboard
        "$mainMod, D, exec, wl-paste | xargs yt-dlp"

        # Move focus 
        "$mainMod, H, cyclenext, prev"
        "$mainMod, L, cyclenext, "
        "$mainMod CTRL, H, swapnext, prev"
        "$mainMod CTRL, L, swapnext, "
        "$mainMod SHIFT, S, swapactiveworkspaces, current +1"
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

      bindl = [
        # Control mpd with headphones
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl --all-players pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      bindel = [
        # Volume
        "$mainMod, right, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%; $notifyVolume"
        "$mainMod, left, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%; $notifyVolume"
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%; $notifyVolume"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%; $notifyVolume"

        # Monitor brightness
        "$mainMod, up, exec, light -A 5; $notifyBacklight"
        "$mainMod, down, exec, light -U 5; $notifyBacklight"
        ", XF86MonBrightnessUp , exec, light -A 5; $notifyBacklight"
        ", XF86MonBrightnessDown , exec, light -U 5; $notifyBacklight"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
