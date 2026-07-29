{ pkgs, unstable-pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qmplay2-qt5
    unstable-pkgs.vlc
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
