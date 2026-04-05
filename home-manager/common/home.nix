{ pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cole";
  home.homeDirectory = "/home/cole";

  home.stateVersion = "25.11";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    foot
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
    dust
  ];
}
