{ ... }:
{
  imports = [
    ./eww.nix
    ./fuzzel.nix
    ./gtk.nix
    ./mako.nix
    ./kitty.nix
    ./hyprland.nix
  ];

  programs.yt-dlp = {
    enable = true;

    settings = {
      paths = "~/Videos/Youtube/";
      output = ''%(playlist|Individual)s/%(playlist_index&{}\ -\ |)s%(title)s.%(ext)s'';
    };
  };

  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        play = [
          { run = "qmplay2 \"$@\""; orphan = true; for = "unix"; }
        ];
      };
    };
  };

  home.file = {
    "wallpapers" = {
      source = ../../Assets/wallpapers;
      target = "Pictures/wallpapers";
    };
  };
}
