{ pkgs, ... }:
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
    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "<C-n>" ];
          run = ''shell -- dragon-drop -x -T "$1"'';
        }
      ];
    };
  };

  home.file = {
    "wallpapers" = {
      source = ../../Assets/wallpapers;
      target = "Pictures/wallpapers";
    };
    ".icons/Papirus-Dark".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
  };
}
