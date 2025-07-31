{ config, pkgs, ... }:

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
    xournalpp
    neofetch
    ripgrep
    btop
    nixfmt-rfc-style
    krita
    spotify
    discord
    kdePackages.filelight
    networkmanagerapplet
    helvum
    pwvucontrol
    pcmanfm
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "neovim";
  };

  services = {
    syncthing = {
      enable = true;
      tray.enable = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Cole Kauder-McMurrich";
    userEmail = "gamingwithcole7@gmail.com";
  };

  programs.firefox.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
      jnoortheen.nix-ide
    ];
  };
}
