{ pkgs, inputs, ... }:
{
  nix.settings.trusted-users = [ "root" "mdario" ];
  users.users.mdario = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "rtkit" "docker" ];
    packages = with pkgs; [
      aria2
      (nemo-with-extensions.override {
        useDefaultExtensions = false;
        extensions = [ nemo-fileroller ];
      })
      filezilla
      ffmpeg
      # web browser
      firefox
      chromium
      # for reading ebooks
      foliate
      # terminal emulator
      kitty
      # for painting
      krita
      pinta
      libreoffice
      papirus-icon-theme
      wine
      # for screen recording
      obs-studio
      # add system tray icons, needs to be enabled with Extensions. 
      gnomeExtensions.appindicator

      # to run .jar files, particularly JDownloader2
      jre

      # ... yes, truly necessary
      fortune
      neo-cowsay
    ];
  };

  # Shell
  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;
}
