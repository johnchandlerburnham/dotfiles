{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    gfxmodeBios="2560x1440";
    extraConfig="set gfxpayload=keep"; 
    device = "/dev/sda"; 
  };

  networking = {
    hostName = "daphne";
    #wireless.enable = true; 
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
      inconsolata-lgc
      inconsolata
      ubuntu_font_family
    ];
  };

  environment.systemPackages = with pkgs; [
    audacity
    emacs
    feh
    firefox
    ghc
    git
    rxvt_unicode
    pavucontrol
    psmisc
    qutebrowser
    taffybar
    vim
    wget
    xorg.xmodmap
    xorg.xev
  ];

  programs.fish.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable the X11 windowing system.
  services = {
    openssh.enable = true;

    xserver = {
      enable = true;
      layout = "us";
      videoDrivers = [ "nvidia" ];

      displayManager.lightdm.enable = true;
      displayManager.sessionCommands = 
        ''
          [[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
          feh --bg-scale ~/.xmonad/background.jpg
        ''
      desktopManager = {
        default = "none";
      };

      windowManager.xmonad.enable = true;
      windowManager.xmonad.enableContribAndExtras = true;
    };
  };

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
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal"
    ];
    shell = pkgs.fish;
    uid = 1000;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
