{ pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./user.nix
  ];

  # Basic config
  # Define your hostname.
  networking.hostName = "MDario";
  # Set your time zone
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "all" ];
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-rime
          fcitx5-pinyin-moegirl
          fcitx5-table-extra
        ];
      };
    };
  };
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # NFS server
  services.static-web-server = {
    enable = true;
    listen = "[::]:80";
    root = "/export";
    configuration = {
      general = {
        directory-listing = true;
      };
    };
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    bandwhich
    bottom
    fd
    fzf
    home-manager
    jq
    neovim
    ouch
    pulseaudioFull
    ripgrep
    socat
    starship
    tldr
    unrar
    unzip
    vim
    wl-clipboard
    yq-go
    zoxide
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
    font-awesome
    hachimarupop
    jigmo
    noto-fonts
  ];

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # Do NOT change this value 
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}
