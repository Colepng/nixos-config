{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./user-configuration
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cole";
  home.homeDirectory = "/home/cole";

  home.stateVersion = "25.11";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    rnote
    kdePackages.ark
    xwayland-satellite
    neofetch
    ripgrep
    btop
    nixfmt-rfc-style
    krita
    vesktop
    kdePackages.filelight
    networkmanagerapplet
    helvum
    pwvucontrol
    pcmanfm
    gitkraken
    nil
    kdePackages.qtdeclarative
    mpv
    racket
    vlc
    evince
    nvtopPackages.intel
    linuxKernel.packages.linux_zen.cpupower
    libreoffice-fresh
    hunspell
    hunspellDicts.en_CA
    gnome-software
  ];
  programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi # optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

  programs.dank-material-shell = {
    enable = true;

    dgop.package = inputs.dgop.packages.${pkgs.system}.default;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
    };

    niri = {
      enableKeybinds = true; # Sets static preset keybinds
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = false; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting items from the clipboard (wtype)

    settings = {
      theme = "dark";
      dynamicTheming = true;
      # Add any other settings here
    };

    session = {
      isLightMode = false;
      # Add any other session state settings here
    };

    clipboardSettings = {
      maxHistory = 25;
      maxEntrySize = 5242880;
      autoClearDays = 1;
      clearAtStartup = true;
      disabled = false;
      disableHistory = false;
      disablePersist = true;
    };
  };

  programs.niri.settings = {
    input.tablet.map-to-output = "eDP-1";
  };

  # systemd.user.services.niri-flake-polkit.enable = false;

  programs = {
    direnv = {
      enable = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      settings = {
        user = {
          email = "cole@colepng.com";
          name = "Cole Kauder-McMurrich";
        };
      };

      signing = {
        format = "ssh";
        key = "~/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
    };

    firefox.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };
  };

  services = {
    poweralertd.enable = true;

    syncthing = {
      enable = true;
      tray.enable = true;
    };
  };

  stylix.targets = {
    neovim.enable = false;
  };
}
