{ pkgs, ... }:
{
  # X11 windowing system.
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.options = "caps:backspace";
    desktopManager.gnome.enable = true;
  };
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
}
