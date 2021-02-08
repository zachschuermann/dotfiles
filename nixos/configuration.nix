# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  neovim-nightly-metadata = {
    upattr = "neovim-unwrapped";
    repo_git = "https://github.com/neovim/neovim";
    branch = "master";
    rev = "444e60ab39ec44a51aa3606f007c9272743df6c9";
    sha256 = "0rpsjxqd3a0lalsa7v5pzhr48c27f91310pbm3hf9fq2508kyjd3";
  };
  unstable = import <nixpkgs-unstable> { config.allowUnfree = true; };
  zach-python-packages = python-packages: with python-packages; [
    jupyterlab
    matplotlib
    numpy
    scipy
    pandas
    requests
  ]; 
  python-with-zach-packages = pkgs.python3.withPackages zach-python-packages;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include secret config
      /etc/nixos/secret.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelPackages = unstable.pkgs.linuxPackages_5_10;
  boot.kernelPackages = unstable.pkgs.linuxPackages_latest;

  boot.kernelParams = [
    "usbcore.autosuspend=-1"
    "processor.max_cstate=1"
    # "intel_idle.max_cstate=1" I don't have intel..
  ];

  networking.hostName = "gandalf"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  nixpkgs.config.allowUnfree = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp5s0.useDHCP = true;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  environment.variables = {
    EDITOR = "vim";
  };
  
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.video.hidpi.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zach = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "audio" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bash fish sudo git tmux screen
    curl wget vim git unzip
    htop tree
    fzf ripgrep fd bat dust exa
    wireguard
  
    # busybox - this breaks 'reboot?'
    lsof
    stow 
    bspwm sxhkd
    xorg.xmodmap
    polybarFull
    rofi
    dunst libnotify
    lm_sensors
    xflux-gui
    
    gcc gnumake cmake autoconf pkg-config libtool dpkg
    pandoc zathura python3 binutils ninja

    unstable.rustup
    unstable.rust-analyzer
    stack

    mprime

    unstable.kitty
    unstable.alacritty

    (wrapNeovim (neovim-unwrapped.overrideAttrs(old: {
      version = "0.5.0-${neovim-nightly-metadata.rev}";
      src = fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = neovim-nightly-metadata.rev;
        sha256 = neovim-nightly-metadata.sha256;
      };
      buildInputs = old.buildInputs ++ [ unstable.tree-sitter ];
    })) {})    

    google-chrome
    firefox
    discord
    slack
    zoom-us

    #TODO
    alsaLib
    udev
    python-with-zach-packages
    unstable.julia
  ];

  environment.variables.XCURSOR_SIZE = "32";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  services = {
    xserver = {
      enable = true;
      exportConfiguration = true;
      layout = "us";

      videoDrivers = [ "nvidia" ];

      desktopManager.xterm.enable = false;

      windowManager.bspwm.enable = true;
      # windowManager.bspwm.configFile = "/home/zach/.config/bspwm/bspwmrc";
      # windowManager.bspwm.sxhkd.configFile = "/home/zach/.config/sxhkd/sxhkdrc";

      # displayManager.startx.enable = true;
      displayManager.defaultSession = "none+bspwm";
      displayManager.lightdm.enable = true;
      displayManager.lightdm.greeters.mini = {
        enable = true;
        user = "zach";
      };
      #displayManager.autoLogin.enable = true;
      #displayManager.autoLogin.user = "zach";

      # config = ''
      #   # nvidia-settings: X configuration file generated by nvidia-settings
      #   # nvidia-settings:  version 460.27.04
      #   
      #   Section "ServerLayout"
      #       Identifier     "Layout0"
      #       Screen      0  "Screen0" 0 0
      #       InputDevice    "Keyboard0" "CoreKeyboard"
      #       InputDevice    "Mouse0" "CorePointer"
      #       Option         "Xinerama" "0"
      #   EndSection
      #   
      #   Section "InputDevice"
      #       # generated from default
      #       Identifier     "Mouse0"
      #       Driver         "mouse"
      #       Option         "Protocol" "auto"
      #       Option         "Device" "/dev/input/mice"
      #       Option         "Emulate3Buttons" "no"
      #       Option         "ZAxisMapping" "4 5"
      #   EndSection
      #   
      #   Section "InputDevice"
      #       # generated from default
      #       Identifier     "Keyboard0"
      #       Driver         "kbd"
      #   EndSection
      #   
      #   Section "Monitor"
      #       # HorizSync source: edid, VertRefresh source: edid
      #       Identifier     "Monitor0"
      #       VendorName     "Unknown"
      #       ModelName      "HPN HP Z27"
      #       HorizSync       28.0 - 135.0
      #       VertRefresh     29.0 - 60.0
      #       Option         "DPMS"
      #   EndSection
      #   
      #   Section "Device"
      #       Identifier     "Device0"
      #       Driver         "nvidia"
      #       VendorName     "NVIDIA Corporation"
      #       BoardName      "GeForce GTX 1080"
      #   EndSection
      #   
      #   Section "Screen"
      #       Identifier     "Screen0"
      #       Device         "Device0"
      #       Monitor        "Monitor0"
      #       DefaultDepth    24
      #       Option         "Stereo" "0"
      #       Option         "nvidiaXineramaInfoOrder" "DFP-5"
      #       Option         "metamodes" "DP-2: nvidia-auto-select +2160+840, HDMI-0: nvidia-auto-select +0+0 {rotation=left}"
      #       Option         "SLI" "Off"
      #       Option         "MultiGPU" "Off"
      #       Option         "BaseMosaic" "off"
      #       SubSection     "Display"
      #           Depth       24
      #       EndSubSection
      #   EndSection
      # '';
      screenSection = "Option \"metamodes\" \"DP-2: nvidia-auto-select +2160+840, HDMI-0: nvidia-auto-select +0+0 {rotation=left}\"";
      dpi = 192;
    };
    datadog-agent = {
      enable = true;
      apiKeyFile = builtins.path { path = "/home/zach/.dd-key"; name = "dd-key"; };
    };
  };
  fonts = {
        enableFontDir = true;
        enableGhostscriptFonts = true;
        fonts = with pkgs; [
          corefonts
          inconsolata
          terminus_font
          proggyfonts
          dejavu_fonts
          font-awesome
          font-awesome-ttf
          ubuntu_font_family
          source-code-pro
          source-sans-pro
          source-serif-pro
          symbola
          noto-fonts-cjk
          envypn-font
          unifont
          material-icons
          noto-fonts noto-fonts-emoji noto-fonts-extra
          siji
        ];
  };

  virtualisation.docker.enable = true;
  hardware.opengl.driSupport32Bit = true;
  virtualisation.docker.enableNvidia = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?




}

