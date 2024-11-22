{ ... }:
{
  imports = [
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
}
