{
  pkgs,
  lib,
  ...
}:

{
  # input settings
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      # fcitx5-gtk
      # fcitx5-qt6
      # rime-data
      # fcitx5-rime
      # fcitx5-chinese-addons
      # fcitx5-nord
    ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # networking
  networking.hostName = lib.mkDefault "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cole = {
    isNormalUser = true;
    description = "Cole Kauder-McMurrich";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs; [
    gparted
    texlive.combined.scheme-full
    git
  ];

  system.stateVersion = "25.11";
}
