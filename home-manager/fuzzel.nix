{ config, lib, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "FantasqueSansM Nerd Font Mono:size=12";
        dpi-aware = "auto";
        icon-theme = "hicolor";
        icons-enable = "yes";
        anchor = "center";
        lines = 10;
        width = 30;
        tabs = 8;
        horizontal-pad = 20;
        vertical-pad = 8;
        inner-pad = 0;
        image-size-ratio = 0.2;
        line-height = 26;
        letter-spacing = 0;
        layer = "top";
        exit-on-keyboard-focus-loss = "yes";
      };
      colors = {
        background = "1e1e2eff";
        text = "cdd6f4ff";
        match = "f38ba8ff";
        selection = "585b70ff";
        selection-match = "f38ba8ff";
        selection-text = "cdd6f4ff";
        border = "c0a0f0ff";
      };
      border = {
        width = 2;
        radius = 20;
      };
    };
  };
}
