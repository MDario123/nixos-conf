{ lib, pkgs, inputs, ... }:

let
  sddm-glacier = builtins.fetchGit {
    url = "https://github.com/MDario123/sddm-glacier";
    rev = "9c9c37645bdaddc398405f1b80b3189e64e58482";
  };
in
{
  # Don't show text during boot
  boot.kernelParams = [ "quiet" "splash" ];
  boot.consoleLogLevel = 3;
  boot.loader.grub = {
    enable = true;

    copyKernels = true;
    efiSupport = true;
    device = "nodev";
    # useOSProber = true;
    fsIdentifier = "label";

    theme = "${pkgs.catppuccin-grub.override { flavor = "mocha"; }}/";

    extraEntries = ''
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      }
    '';
  };

  # Support NTFS
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "MDario"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    audio.enable = true;
  };

  services.libinput.enable = true;
  # X11 windowing system.
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.options = "caps:backspace";
    desktopManager.gnome.enable = true;
  };
  services.displayManager.sddm = {
    enable = true;
    theme = "glacier";
    extraPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtmultimedia
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
    ];
  };
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mdario = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" ];
    packages = with pkgs; [
      aria2
      (nemo-with-extensions.override {
        useDefaultExtensions = false;
        extensions = [ nemo-fileroller ];
      })
      discord
      filezilla
      # web browser
      firefox
      inputs.zen-browser.packages."${system}".specific
      # for reading ebooks
      foliate
      # terminal emulator
      kitty
      # for painting
      pinta
      libreoffice
      papirus-icon-theme
      telegram-desktop
      wine
      # for screen recording
      obs-studio
      # add system tray icons, needs to be enabled with Extensions. 
      gnomeExtensions.appindicator

      # to run .jar files, particularly JDownloader2
      jre

      # ... yes, truly necessary
      fortune
      neo-cowsay
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bottom
    eza
    fd
    ffmpeg
    fzf
    home-manager
    htop
    lshw
    jq
    neovim
    obsidian
    openvpn
    ouch
    pulseaudioFull
    ripgrep
    socat
    starship
    tldr
    tree
    unrar
    unzip
    vim
    wget
    wl-clipboard
    w3m
    zoxide

    (pkgs.callPackage sddm-glacier {
      themeConfig = {
        Background = "${./wallpapers/nixos.png}";
      };
    })
  ];

  environment.variables = {
    SHELL = "$(which zsh)";
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    font-awesome
    noto-fonts
  ];

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Do NOT change this value 
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

}
