{ pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cole";
  home.homeDirectory = "/home/cole";

  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    rnote
    kdePackages.ark
    kdePackages.dolphin
    fastfetch
    ripgrep
    btop
    nixfmt
    vesktop
    kdePackages.filelight
    networkmanagerapplet
    crosspipe
    pwvucontrol
    gitkraken
    nil
    kdePackages.qtdeclarative
    mpv
    racket
    vlc
    evince
    nvtopPackages.intel
    linuxKernel.packages.linux_zen.cpupower
    hunspell
    hunspellDicts.en_CA
    gnome-software
    dust
    spotify
    piper
    hyprshot
    taskwarrior-tui
    taskwarrior3
    jellyfin-mpv-shim
    jetbrains.idea
    eddie
    telegram-desktop
    vscode
  ];
}
