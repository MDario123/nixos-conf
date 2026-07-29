{ config, pkgs, ... }:

let
  hyprsunset-auto = (
    pkgs.writeShellScriptBin "hyprsunset-auto" ''
      # Configuration
      SUNRISE_TIME="06:00" # Sunrise time
      SUNSET_TIME="18:00"  # Sunset time
      DEFAULT_TEMP=6000  # Default temperature (daylight)
      NIGHT_TEMP=3700      # Temperature at midnight
      GRADUAL_INTERVAL=300  # Interval for gradual changes (in seconds)

      # Function to convert time to minutes since midnight
      time_to_minutes() {
          IFS=: read -r hour minute <<<"$1"
          echo $((10#$hour * 60 + 10#$minute))
      }

      # Function to calculate temperature based on time
      calculate_temp() {
          local current_minutes=$(time_to_minutes "$1")
          local sunrise_minutes=$(time_to_minutes "$SUNRISE_TIME")
          local sunset_minutes=$(time_to_minutes "$SUNSET_TIME")
          local night_duration=$((1440 - sunset_minutes + sunrise_minutes)) # Total night duration in minutes
          local night_midpoint=$((sunset_minutes + night_duration / 2))
          local adjusted_minutes=$((current_minutes < sunrise_minutes ? current_minutes + 1440 : current_minutes))

          if ((sunrise_minutes <= current_minutes && current_minutes < sunset_minutes)); then
              # Daytime: Constant temperature
              echo $DEFAULT_TEMP
          else
              # Nighttime: Gradual change
              if ((adjusted_minutes <= night_midpoint)); then
                  # First half of the night: Decrease temperature
                  progress=$(( (adjusted_minutes - sunset_minutes) * 1000 / (night_midpoint - sunset_minutes) ))
                  temp=$((DEFAULT_TEMP - (DEFAULT_TEMP - NIGHT_TEMP) * progress / 1000))
              else
                  # Second half of the night: Increase temperature
                  progress=$(( (adjusted_minutes - night_midpoint) * 1000 / (sunrise_minutes + 1440 - night_midpoint) ))
                  temp=$((NIGHT_TEMP + (DEFAULT_TEMP - NIGHT_TEMP) * progress / 1000))
              fi
              echo $temp
          fi
      }

      # Main loop
      while true; do
          current_time=$(date +"%H:%M")
          temperature=$(calculate_temp "$current_time")
          hyprctl hyprsunset temperature "$temperature"
          sleep "$GRADUAL_INTERVAL" # Sleep for the gradual interval
      done
    ''
  );
  get-lock-wallpaper = (
    pkgs.writeShellScriptBin "get-lock-wallpaper" ''
      # Directory containing files
      folder="${config.home.homeDirectory}/Pictures/wallpapers/lock"

      # Get the number of files in the folder
      num_files=$(ls "$folder" | wc -l)

      # Calculate the file index based on the current time
      index=$(( $(date +%s) / 15 % num_files ))

      # Get the file to return based on the calculated index
      file=$(ls "$folder" | sort | sed -n "$((index + 1))p")

      # Print the file path
      echo "$folder/$file"
    ''
  );
in
{
  home.packages = [
    hyprsunset-auto
    get-lock-wallpaper
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

  xdg.configFile = {
    "hyprlock.conf" = {
      source = ../../Assets/hyprlock.conf;
      target = "hypr/hyprlock.conf";
    };
    "hyprpaper.conf" = {
      source = ../../Assets/hyprpaper.conf;
      target = "hypr/hyprpaper.conf";
    };
  };

  home.file = {
    ".local/bin/desktop_commands" = {
      enable = true;
      source = ../../Assets/bin/desktop_commands;
    };
  };
}
