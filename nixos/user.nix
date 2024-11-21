{ pkgs, inputs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mdario = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" ];
    packages = with pkgs; [
      aria2
      (nemo-with-extensions.override {
        useDefaultExtensions = false;
        extensions = [ nemo-fileroller ];
      })
      discord
      filezilla
      ffmpeg
      # web browser
      firefox
      inputs.zen-browser.packages."${system}".specific
      # for reading ebooks
      foliate
      # terminal emulator
      kitty
      # for painting
      pinta
      libreoffice
      papirus-icon-theme
      telegram-desktop
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
