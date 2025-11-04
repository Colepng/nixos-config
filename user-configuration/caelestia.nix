# Nix os module that configures caelestia for users
{
  lib,
  config,
  pkgs,
  ...
}:

{
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true; # if you prefer starting from your compositor
      target = "graphical-session.target";
      environment = [ ];
    };
    settings = {
      background = {
        enabled = true;
        desktopClock.enabled = true;
        visualiser = {
          autoHide = true;
          blur = false;
          enabled = false;
          rounding = 1;
          spacing = 1;
        };
      };
      bar = {
        status = {
          showAudio = true;
          showBattery = true;
          showBluetooth = true;
          showKbLayout = true;
          showLockStatus = true;
          showMicrophone = true;
          showNetwork = true;
        };
        tray = {
          background = false;
          compact = false;
          iconSubs = [ ];
          recolour = false;
        };
      };
      launcher = {
        showOnHover = true;
      };
      lock = {
        recolourLogo = true;
      };
      notifs = {
        actionOnClick = true;
        clearThreshold = 0.3;
        defaultExpireTimeout = 5000;
        expandThreshold = 20;
        expire = true;
      };
      osd = {
        enableBrightness = true;
        enableMicrophone = false;
        enabled = true;
        hideDelay = 1000;
      };
      paths.wallpaperDir = "/home/cole/Pictures/Wallpapers/Dark/";
      services = {
        audioIncrement = 0.1;
        defaultPlayer = "Spotify";
        gpuType = "";
        maxVolume = 1;
        playerAliases = [
          {
            from = "com.github.th_ch.youtube_music";
            to = "YT Music";
          }
        ];
        smartScheme = true;
        useFahrenheit = false;
        useTwelveHourClock = false;
        visualiserBars = 45;
        weatherLocation = "";
      };
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme.enableGtk = true;
      };
    };
  };
}
