{ pkgs, config, ... }:

{
  services = {
    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    tailscale.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
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

    #auto mounting
    udisks2.enable = true;

    #firmware updating
    fwupd.enable = true;
    fwupd.uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;

    #managed flatpacks
    flatpak = {
      enable = true;
      packages = [
        "com.fastmail.Fastmail"
      ];
      uninstallUnmanaged = true;
    };
    # ssh
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = [ "cole" ]; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };
  };

  services.blueman.enable = true;

  services.iio-niri.enable = true;

  # needed by pipewire
  security.rtkit.enable = true;
}
