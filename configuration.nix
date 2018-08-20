{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
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
      inconsolata-lgc
      inconsolata
      ubuntu_font_family
      nerdfonts
    ];
    fontconfig.defaultFonts.monospace = [
      "Inconsolata Nerd Font"
      "Inconsolata LGC"
      "Inconsolata"
    ];
  };


  environment.systemPackages = with pkgs; [
    audacity
    clipit
    dmenu
    dbus
    feh
    firefox
    git
    rxvt_unicode
    rofi
    oh-my-zsh
    pavucontrol
    psmisc
    taffybar
    termite
    tmux
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
    enableAutosuggestions = true;
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

  virtualisation.virtualbox.host.enable = true;
  nixpkgs.config.virtualbox.enableExtensionPack = true;
  virtualization.virtualbox.host.enableHardening = false;

  # Enable the X11 windowing system.
  services = {
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
        extraPackages = haskellPackages: [
          haskellPackages.dbus
          haskellPackages.taffybar
        ];
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
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "vboxusers"
    ];
    shell = pkgs.zsh;
    uid = 1000;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
