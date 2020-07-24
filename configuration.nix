{ config, pkgs, ... }:

let
  unstable = import <nixpkgs> {};
  myPython = pkgs.python37Full.withPackages(ps: [ ps.pynvim ]);
in {
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  # nixpkgs.overlays = [ (import ./taffybar-overlay.nix)];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  boot.extraModulePackages = [
    pkgs.linuxPackages.nvidia_x11
  ];

  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
    ];
    trustedUsers = [ "root" "jcb" ];
  };

  virtualisation.docker.enable = false;

  networking = {
    hostName = "daphne";
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowedUDPPorts = [ 631 ];
    firewall.allowedTCPPorts = [ 80 631 ];
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "America/New_York";

  fonts ={
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      hack-font
      hasklig
      ubuntu_font_family
      dejavu_fonts
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      symbola
      source-code-pro
      liberation_ttf
    ];
    fontconfig.defaultFonts.monospace = [
      "Inconsolata LGC Nerd Font"
      "Noto Sans Mono CJK JP"
      "Noto Sans Hebrew"
      "Noto Color Emoji"
      "Noto Sans Symbols"
      "Noto Sans Mono Nerd Font"
      "DejaVu Sans Mono Nerd Font"
      "Symbola"
    ];
  };

  environment.systemPackages = with pkgs; [
    haskellPackages.Agda
    binutils
    blueman
    clipit
    coq
    chromium
    dbus
    dmenu
    feh
    firefox
    git
    ghc
    gimp
    graphviz
    gnumake
    gcc
    idris
    libreoffice
    light
    openssl
    pavucontrol
    pkgconfig
    psmisc
    purescript
    neovim
    rxvt_unicode
    rofi
    carnix
    unstable.rustc
    unstable.rustup
    termite
    tmux
    # taffybar
    qutebrowser
    myPython
    wine
    wget
    numix-cursor-theme
    numix-gtk-theme
    numix-icon-theme
    numix-icon-theme-circle
    numix-icon-theme-square
    numix-solarized-gtk-theme
    xfce.xfce4-clipman-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-cpufreq-plugin
    #xfce.xfce4-fsguard-plugin
    xfce.xfce4-hardware-monitor-plugin
    xfce.xfce4-weather-plugin
    xfce.xfce4-xkb-plugin
    xfce.xfce4-sensors-plugin
    xorg.xmodmap
    xorg.xev
    xorg.libXinerama
    stack
    steam
    zlib
    fish
  ];

  programs.system-config-printer.enable = true;

  programs.fish = {
    enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true;
  };

  hardware.bluetooth = {
    enable = true;
    config = { General = { Enable = "Source,Sink,Media,Socket"; };};
    powerOnBoot = true;
  };

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable the X11 windowing system.
  services = {

    avahi = {
      publish.enable = true;
      enable = true;
      nssmdns = true;
    };

    blueman.enable = true;

    openssh.enable = true;

    printing = {
      enable = true;
      drivers = with pkgs; 
        [ brlaser brgenml1lpr brgenml1cupswrapper gutenprint gutenprintBin ];
      browsing = true;
    };

    xserver = {
      enable = true;
      libinput.enable = true;
      config =
      ''
       Section "Monitor"
         Identifier "HDMI-0"
       EndSection

       Section "Monitor"
         Identifier "DP-0"
         Option     "Primary" "true"
       EndSection
      '';

      layout = "us";
      videoDrivers = [ "nvidia" ];

      displayManager.lightdm.enable = true;
      displayManager.defaultSession = "xfce";

      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      # synaptics = {
      #   enable = true;

      #   # http://who-t.blogspot.fr/2010/11/how-to-ignore-configuration-errors.html
      #   dev = "/dev/input/event*";
      #   twoFingerScroll = true;
      #   accelFactor = "0.001";
      #   buttonsMap = [ 1 3 2 ];
      #   tapButtons = false;
      #   palmDetect = true;
      #   additionalOptions = ''
      #     Option "VertScrollDelta" "-180"
      #     Option "HorizScrollDelta" "-180"
      #     Option "FingerLow" "40"
      #     Option "FingerHigh" "70"
      #     Option "Resolution" "270"
      #   '';
      # };


    };

    udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1b7c", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="2b7c", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="3b7c", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="4b7c", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1807", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2581", ATTRS{idProduct}=="1808", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0000", MODE="0660", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0001", MODE="0660", GROUP="plugdev"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev", ATTRS{idVendor}=="2c97"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev", ATTRS{idVendor}=="2581"
  SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2300", SYMLINK+="model01", ENV{ID_MM_DEVICE_IGNORE}:="1", ENV{ID_MM_CANDIDATE}:="0"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2301", SYMLINK+="model01", ENV{ID_MM_DEVICE_IGNORE}:="1", ENV{ID_MM_CANDIDATE}:="0"
  '';
  };

  swapDevices = [
    { device = "/swapfile"; }
  ];

  #system.activationScripts.etcX11sessions = ''
  #  echo "setting up /etc/X11/sessions..."
  #  mkdir -p /etc/X11
  #  [[ ! -L /etc/X11/sessions ]] || rm /etc/X11/sessions
  #  ln -sf ${config.services.xserver.displayManager.session.desktops} /etc/X11/sessions
  #'';

  users.extraGroups.plugdev = { gid = 1011; };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.jcb = {
    name = "jcb";
    isNormalUser = true;
    extraGroups = [
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "docker"
      "plugdev" "dialout" "uucp"
    ];
    shell = pkgs.fish;
    uid = 1000;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

}
