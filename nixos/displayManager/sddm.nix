{ pkgs, ... }:

let
  sddm-glacier = builtins.fetchGit {
    url = "/home/mdario/Documents/Projects/Personal/sddm-glacier/";
    rev = "cac45486b010198a33f0803e9f864bbbd0d269be";
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "glacier";
    extraPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtmultimedia
    ];
    package = pkgs.libsForQt5.sddm;
  };

  environment.systemPackages = [
    (pkgs.callPackage sddm-glacier {
      themeConfig = {
        Background = "${../../Assets/wallpapers/nixos.png}";
        AnimatedBackground = "${../../Assets/wallpapers/video.mp4}";
        AnimationSpeedMultiplier = (144 / 60);
      };
    })
  ];
}
