{
  pkgs,
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
    neofetch
    ripgrep
    btop
    nixfmt-rfc-style
    krita
    discord
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
          email = "gamingwithcole7@gmail.com";
          name = "Cole Kauder-McMurrich";
        };
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
