{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <nixos/modules/programs/command-not-found/command-not-found.nix>
    ];

  time.timeZone = "America/Montreal";

  # nix.binaryCaches = [ http://cache.nixos.org ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  networking = {
    hostName = "bob";
    wireless.enable = true;
  };

  i18n = {
     consoleFont = "";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    # popcorntime
    acpi
    ansible
    atom
    chromiumDev
    dmenu
    docker
    git
    gimp
    # haskellPackages.purescript
    # haskellPackages.ghc
    idea.idea-community
    mercurial # command-not-found script
    mplayer
    nix
    # - nixops
    # nodejs
    oraclejdk8
    octave
    rxvt_unicode
    sbt
    scala_2_11
    scrot
    sublime3
    tig
    tree
    unzip
    wpa_supplicant_gui
    xclip
    xlibs.xbacklight
  ];

  services = {
    samba.enable = true;
    # openssh.enable = true;
    # printing.enable = true;
    peerflix.enable = true;
    #deluge = {
    #  enable = true;
    #  web.enable = true;
    #};

    upower.enable = true;
    nixosManual.showManual = false;

    xserver = {
      videoDrivers = [ "nvidia" ];
      enable = true;
      layout = "en";

      synaptics = {
        enable = true;
        palmDetect = true;
        tapButtons = true;
        twoFingerScroll = true;
        accelFactor = "0.01";
	      maxSpeed = "2";
      };

      windowManager = {
        # default = "xmonad";
        # xmonad.enable = true;
        # xmonad.enableContribAndExtras = true;
      };
      
      desktopManager = {
        default = "none";
        xterm.enable = false;
      };
      displayManager = {
        slim = {
          autoLogin = true;
          enable = true;
          defaultUser = "gui";
        };
        sessionCommands = ''
          ${pkgs.xlibs.xrdb}/bin/xrdb -all ~/.Xresources
          ${pkgs.xlibs.xsetroot}/bin/xsetroot -cursor_name left_ptr
          ${pkgs.xlibs.xset}/bin/xset r rate 200 50
          ${pkgs.xlibs.xinput}/bin/xinput set-prop 8 "Device Accel Constant Deceleration" 3
          ${pkgs.redshift}/bin/redshift &
          ${pkgs.compton}/bin/compton -r 4 -o 0.75 -l -6 -t -6 -c -G -b
          ${pkgs.hsetroot}/bin/hsetroot -solid '#000000'
        '';
      };
    };
  };

  programs = {
    # ssh.startAgent = true;
    zsh.enable = true;
  };
  

  users = {
    mutableUsers = true;
    extraUsers.gui = {
      name = "gui";
      group = "users";
      uid = 1000;
      extraGroups = [ "wheel" ];
      createHome = true;
      home = "/home/gui";
      shell = "/run/current-system/sw/bin/zsh";
    };
    extraGroups.docker.members = [ "gui" ];
  };
  security.sudo.wheelNeedsPassword = false;
  
  nixpkgs.config = {
    # virtualbox.enableExtensionPack = true;
    allowUnfree = true;
    allowBroken = true;
    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
    };
    oraclejdk8 = {
      installjce = true;
    };
    packageOverrides = pkgs : rec {
      jdk = pkgs.oraclejdk8;
      jre = pkgs.oraclejdk8.jre;
    };
  };


  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
  };

  fonts = {
    enableGhostscriptFonts = true;
    fontconfig.enable = true;
    enableCoreFonts = true;
    fonts = with pkgs; [
      clearlyU
      cm_unicode
      dejavu_fonts
      dosemu_fonts
      freefont_ttf
      proggyfonts
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family
      unifont
      vistafonts
      powerline-fonts
    ];
  };
}
