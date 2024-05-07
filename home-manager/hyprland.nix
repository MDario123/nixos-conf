{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = false;
    settings = {
      monitor = [
        "eDP-1, 1920x1080@60, 0x0, 1"
        ", preferred, auto, 1"
      ];
    };
  };
}
