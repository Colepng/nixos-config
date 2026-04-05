{ inputs, pkgs, ... }:
{
  programs = {
    dank-material-shell = {
      enable = true;

      dgop.package = inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.default;

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
        maxHistory = 25000;
        maxEntrySize = 5242880;
        autoClearDays = 0;
        clearAtStartup = false;
        disabled = false;
        disableHistory = false;
        disablePersist = false;
      };
    };

    niri.settings = {
      input.tablet.map-to-output = "eDP-1";
    };

    # systemd.user.services.niri-flake-pol kit.enable = false;
  };
}
