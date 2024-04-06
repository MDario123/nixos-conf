
{ config, lib, pkgs, ... }: 

{
  services.gnome.gnome-keyring.enable = true;
  # programs.seahorse.enable = true; # enable the graphical frontend
  security.pam.services.gdm.enableGnomeKeyring = true; # load gnome-keyring at startup
  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";

  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    bemenu
    eww
    grim
    hyprlock
    hyprpaper
    libsecret
    libnotify
    mako
    slurp
    waybar
  ];
}
