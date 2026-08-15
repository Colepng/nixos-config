{ config, lib, ... }:

{
  home-manager.users.cole = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "DP-2,3840x2160@240, 0x0, 1.5, bitdepth, 10, cm, auto"
        "HDMI-A-2,1680x1050@60, 2560x0, 1"
        # "eDP-2, disabled"
      ];

      # cursor = {
      #   no_hardware_cursors = true;
      # };

      workspace = [
        "1, monitor:DP-2"
        "2, monitor:DP-2"
        "3, monitor:DP-2"
        "4, monitor:DP-2"
        "5, monitor:DP-2"
        "6, monitor:DP-2"
        "7, monitor:DP-2"
        "8, monitor:DP-2"
        "9, monitor:DP-2"
        "10, monitor:DP-2"
        "11, monitor:HDMI-A-2"
        "12, monitor:HDMI-A-2"
        "13, monitor:HDMI-A-2"
        "14, monitor:HDMI-A-2"
        "15, monitor:HDMI-A-2"
        "16, monitor:HDMI-A-2"
        "17, monitor:HDMI-A-2"
        "18, monitor:HDMI-A-2"
        "19, monitor:HDMI-A-2"
        "20, monitor:HDMI-A-2"
      ];

      plugins = [ ];

      animations = {
        enabled = true;

        workspace_wraparound = true;

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
      };

      # experimental = {
      #   xx_color_management_v4 = true;
      # };
    };
  };
}
