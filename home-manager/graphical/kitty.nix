{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "FantasqueSansM Nerd Font Mono";
      size = 13;
      package = with pkgs; (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; });
    };
    settings = {
      tab_bar_min_tabs = 2;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
    themeFile = "Catppuccin-Mocha";
    extraConfig = ''
      map f1 launch --cwd=current
      map f2 close_window
      enabled_layouts tall,fat
    '';
  };
}
