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
    theme = "glacier";
    extraPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtmultimedia
    ];
    package = pkgs.libsForQt5.sddm;
  };

  environment.systemPackages = with pkgs; [
    (pkgs.callPackage sddm-glacier {
      themeConfig = {
        Background = "${./wallpapers/nixos.png}";
        AnimatedBackground = "${./wallpapers/video.mp4}";
        AnimationSpeedMultiplier = (144 / 60);
      };
    })
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-libav
  ];

  environment.variables = {
    GST_PLUGIN_SYSTEM_PATH = "${pkgs.gst_all_1.gstreamer.out}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-libav}/lib/gstreamer-1.0";
  };
}
