{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
  nixos1709 = import <nixos1709> {};
  myPython = pkgs.python36Full.withPackages(ps: [ ps.neovim ]);
in {
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs : {
      emacs = pkgs.lib.overrideDerivation (pkgs.emacs.override {
        withGTK3 = true;
        imagemagick = pkgs.imagemagickBig;
      }) (attrs: {});
  };
};

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
      "https://nixcache.reflex-frp.org"
    ];
    binaryCachePublicKeys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    ];
    trustedUsers = [ "root" "jcb" ];
  };


  virtualisation.docker.enable = true;

  networking = {
    hostName = "daphne";
    networkmanager.enable = true;
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

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
    audacity
    binutils
    clipit
    dbus
    dmenu
    feh
    firefox
    git
    gnumake
    gcc
    imagemagick7Big
    oh-my-zsh
    openssl
    pavucontrol
    pkgconfig
    psmisc
    rxvt_unicode
    rofi
    termite
    tmux
    nixos1709.taffybar
    neovim
    qutebrowser
    myPython
    (vim_configurable.override {
      python = myPython;
      wrapPythonDrv = true;
    })
    wget
    xorg.xmodmap
    xorg.xev
    xorg.libXinerama
    ghc
    stack
    steam
    zlib
    zsh
  ];


  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  hardware.opengl.enable = true;
    hardware.opengl.driSupport32Bit = true;

  # Enable the X11 windowing system.
  services = {
    emacs = {
      install = true;
      defaultEditor = false;
    };

    openssh.enable = true;

    xserver = {
      enable = true;
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
      desktopManager = {
        default = "none";
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
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
  '';
  };

  swapDevices = [
    { device = "/swapfile"; }
  ];

  system.activationScripts.etcX11sessions = ''
    echo "setting up /etc/X11/sessions..."
    mkdir -p /etc/X11
    [[ ! -L /etc/X11/sessions ]] || rm /etc/X11/sessions
    ln -sf ${config.services.xserver.displayManager.session.desktops} /etc/X11/sessions
  '';

  users.extraGroups.plugdev = { gid = 1011; };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.jcb = {
    name = "jcb";
    isNormalUser = true;
    extraGroups = [
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "docker"
      "plugdev" "dialout" "uucp"
    ];
    shell = pkgs.zsh;
    uid = 1000;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
