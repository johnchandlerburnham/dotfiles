{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
  nixos1709 = import <nixos1709> {};
in {
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    gfxmodeBios="1900x1200";
    extraConfig=
    ''
    set gfxpayload=keep
    '';
    device = "/dev/sda";
  };

  #boot.initrd.kernelModules = [ "fbcon" ];
  boot.kernelParams = [ "fbcon=rotate:1" ];
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
    ];
    fontconfig.defaultFonts.monospace = [
      "Inconsolata LGC Nerd Font"
      "DejaVu Sans Mono Nerd Font"
      "Noto Sans Mono"
      "Noto Sans Mono CJK JP"
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
    rxvt_unicode
    rofi
    oh-my-zsh
    openssl
    pavucontrol
    pkgconfig
    psmisc
    termite
    tmux
    nixos1709.taffybar
    qutebrowser
    vim
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
    #emacs = {
    #  enable = true;
    #  defaultEditor = true;
    #  package = import /home/jcb/.emacs.d { pkgs = pkgs; };
    #};

    openssh.enable = true;

    xserver = {
      enable = true;
      config =
      ''
       Section "Monitor"
         Identifier "HDMI-0"
         Option     "Rotate" "right"
       EndSection

       Section "Monitor"
         Identifier "DP-0"
         Option     "RightOf" "HDMI-0"
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.jcb = {
    name = "jcb";
    isNormalUser = true;
    extraGroups = [
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "docker"
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
