# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./system-configuration
  ];

  boot = {
    loader = {
      # Bootloader.
      systemd-boot.enable = true;
      grub = {
        enable = false;
        device = "/dev/disk/by-uuid/1752-CDF9";
        useOSProber = false;
      };
    };
    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
    plymouth = {
      enable = true;
      # theme = "cuts";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [
            "rings"
            "colorful"
            "lone"
            "square"
            "cuts"
          ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.udisks2.enable = true;
  services.fwupd.enable = true;
  services.fwupd.uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cole = {
    isNormalUser = true;
    description = "Cole Kauder-McMurrich";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  users.defaultUserShell = pkgs.fish;

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/irblack.yaml";
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "Inter Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "Inter Sans";
      };

      monospace = {
        package = pkgs.dejavu_fonts;
        name = "Inter Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  programs.fish.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.spicetify = {
    enable = true;
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system}.extensions; [
      allOfArtist
      wikify
      skipStats
      fullScreen
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs; [
    # git must be instleed for flakes
    git
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05";
}
