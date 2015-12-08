{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  time.timeZone = "America/Montreal";

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  networking = {
    hostName = "mm";
    wireless.enable = true;
  };

  i18n = {
     consoleFont = "";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    acpi   
    atom
    chromium
    dmenu
    gimp
    git
    mercurial # command-not-found script
    mplayer
    nix
    octave
    rxvt_unicode
    tig
    tree
    unzip
    wpa_supplicant_gui
    xclip
    xlibs.xbacklight
  ];

  services = {
    upower.enable = true;
    nixosManual.showManual = false;
    xserver = {
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
        default = "xmonad";
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
      };
      
      desktopManager = {
        default = "none";
        xterm.enable = false;
      };
      displayManager = {
        slim = {
          autoLogin = true;
          enable = true;
          defaultUser = "masou";
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
    zsh.enable = true;
  };
  
  users = {
    mutableUsers = true;
    extraUsers.masou = {
      name = "masou";
      group = "users";
      uid = 1000;
      extraGroups = ["wheel"];
      createHome = true;
      home = "/home/masou";
      shell = "/run/current-system/sw/bin/zsh";
    };
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };
  
  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
    };
    packageOverrides = pkgs : rec {
      kawkab-mono-font = pkgs.callPackage ./kawkab-mono.nix { };
    };
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
      kawkab-mono-font
    ];
  };
}