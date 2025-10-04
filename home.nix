{
  config,
  pkgs,
  caelestia-shell,
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

  home.stateVersion = "25.05";

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
    tinymist
    websocat
  ];

  programs = {
    direnv = {
      enable = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      userName = "Cole Kauder-McMurrich";
      userEmail = "gamingwithcole7@gmail.com";
    };
    firefox.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        vscodevim.vim
        yzhang.markdown-all-in-one
        jnoortheen.nix-ide
      ];
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
