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
    hostName = "bob";
  };

  i18n = {
     consoleFont = "";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    acpi
    ansible
    atom
    nodePackages.bower
    chromium
    dmenu
    docker
    gimp
    git
    nodePackages.grunt-cli
    idea.idea-community
    mercurial # command-not-found script
    mplayer
    nodejs
    nix
    octave
    oraclejdk8
    rxvt_unicode
    sbt
    scala_2_11
    scrot
    sublime3
    tig
    tree
    unzip
    wireshark
    xclip
    xlibs.xbacklight
  ];

  services = {
    upower.enable = true;
    nixosManual.showManual = false;
    postgresql.enable = true;
    mongodb.enable = true;
    xserver = {
      videoDrivers = [ "amd" ];
      enable = true;
      layout = "en";

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
    zsh.enable = true;
  };
  
  users = {
    mutableUsers = true;
    extraUsers.gui = {
      name = "gui";
      group = "users";
      uid = 1000;
      extraGroups = [ "wheel" "wireshark"];
      createHome = true;
      home = "/home/gui";
      shell = "/run/current-system/sw/bin/zsh";
    };
    extraGroups.wireshark.gid = 500;
  };

  security = {
    sudo.wheelNeedsPassword = false;
    setuidOwners = [{ 
      program = "dumpcap";
      owner = "root";
      group = "wireshark";
      setuid = true;
      setgid = false;
      permissions = "u+rx,g+x";
    }];
  };
  
  nixpkgs.config = {
    allowUnfree = true;
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
