# Config for XPS 13 9370 circa mid-2018

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "helion"; # Define your hostname.
  networking.networkmanager.enable = true;

  boot.kernelModules = [ "kvm-intel"];
  boot.kernelParams = [
    "pcie.aspm=force"
    "i915.enable_fbc=1"
    "i915.enable_rc6=7"
    "i915.lvds_downclock=1"
    "i915.enable_guc_loading=1"
    "i915.enable_guc_submission=1"
    "i915.enable_psr=0"
  ];

  #hardware.enableAllFirmare = true;

  powerManagement.enable = true;
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
  nixpkgs.config.allowUnfree = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
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
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    antigen
    clipit
    curl
    dbus
    firefox
    git
    ghc
    qutebrowser
    clipit
    rofi
    stack
    skype
    termite
    tmux
    taffybar
    wget
    vim
    zlib
    zsh
    pavucontrol
    coreutils
    pciutils
    usbutils
    psmisc
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };


  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # List services that you want to enable:
  services = {
    openssh.enable = true;
    printing.enable = true;
    printing.drivers = [ pkgs.gutenprint pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
    dbus.enable = true;
    acpid.enable = true;
    upower.enable = true;
    tlp.enable = true;

    xserver = {
      enable = true;
      layout = "us";

      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;

      xkbOptions = "caps:swapescape";
      libinput = {
        enable = true;
        accelProfile = "flat";
        naturalScrolling = true;
      };
      multitouch.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.jcb = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal"
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
