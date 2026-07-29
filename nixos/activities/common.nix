{ pkgs, unstable-pkgs, ... }:

{
  # Needed for firefox for now
  environment.sessionVariables.XDG_DATA_DIRS = [
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  ];

  environment.systemPackages = with pkgs; [
    # web browser
    chromium
    firefox
    # media players
    qmplay2-qt5
    unstable-pkgs.vlc
    # file manager
    yazi
  ];

  services.flatpak = {
    enable = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [ pkgs.icu ];
    };
  };
}
