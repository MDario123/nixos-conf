# Edit this configuration file to define what should be installed on # your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

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

  services.pipewire.enable = lib.mkForce false;

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
    theme = "sugar-dark";
    extraPackages = [ pkgs.libsForQt5.qt5.qtgraphicaleffects ];
  };
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # Enable sound.
  hardware.pulseaudio.enable = true;

  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mdario = {
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

    (sddm-sugar-dark.override {
      themeConfig = {
        ForceHideCompletePassword = true;

        ScreenWidth = 1920;
        ScreenHeight = 1080;

        Background = "${./wallpapers/nixos.png}";
        MainColor = "white";
        AccentColor = "#c0a0f0";
        PartialBlur = "true";
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
