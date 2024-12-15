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
  i18n.defaultLocale = "en_US.UTF-8";
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
    zoxide
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    font-awesome
    noto-fonts
  ];

  # Do NOT change this value 
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}
