# Nix os module that configures hyprland for users
{ config, pkgs, ... }:

{
  # Pkgs used by hyprland or my hyprland config
  home.packages = with pkgs; [
    fuzzel
    foot
    waybar
    playerctl
    brightnessctl
    iio-hyprland
    jq # needed by iio-hyprland
  ];

  services.mako.enable = true;
  services.swww.enable = true;

  # needed for termainl inside hyprland
  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    enable = true;
    settings = {
      monitor = "eDP-1,preferred,auto,1.25";

      exec-once = [
        "swww restore"
        "iio-hyprland --left-master"
      ];

      xwayland.force_zero_scaling = true;

      general = {
        resize_on_border = true;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

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

      misc = {
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };

      input.touchpad.natural_scroll = true;

      gestures.workspace_swipe = true;

      windowrule = [
        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"

        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      "$mainMod" = "SUPER";
      "$altMod" = "ALT";
      "$altMainMod" = "SUPER + SHIFT";
      "$altAltMainMod" = "SUPER + ALT";

      bindl = [
        "$mainMod, Delete, exit"

        # Audio keys
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMuteMic, exec, wpctl set-mute -l 1 @DEFAULT_AUDIO_SOURCE@ toggle"

        # Brightness keys
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"

        # Media control keys
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];

      bind = [
        # Hyprland interaction
        "$mainMod, Q, killactive"
        "$mainMod, F, togglefloating"
        "$mainMod, M, fullscreen"
        "$AltMainMod, M, fullscreen, 1"
        "$mainMod SHIFT, P, pin"
        "$mainMod, J, togglesplit"
        "$mainMod, X, togglespecialworkspace"

        # Window movment
        # Move focus with mainMod + arrow keys,
        "$mainMod, A, movefocus, l"
        "$mainMod, D, movefocus, r"
        "$mainMod, W, movefocus, u"
        "$mainMod, S, movefocus, d"

        "$altMod, A, swapwindow, l"
        "$altMod, D, swapwindow, r"
        "$altMod, W, swapwindow, u"
        "$altMod, S, swapwindow, d"

        # Apps
        "$mainMod, Space, exec, fuzzel"
        "$mainMod, Return, exec, foot"
        "$altMod, C, exec, firefox --new-tab \"https://app.fastmail.com/calendar/week/\""
        "$altMod, M, exec, firefox --new-tab \"https://app.fastmail.com/mail/Inbox\""
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mainMod, code:1${toString i}, workspace, ${toString ws}"
              "$altMainMod, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        )
      );

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = false;
        ignore_empty_input = true;
      };

      animations = {
        enabled = true;
        fade_in = {
          duration = 300;
          bezier = "easeOutQuint";
        };
        fade_out = {
          duration = 300;
          bezier = "easeOutQuint";
        };
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "<span foreground=\"##cad3f5\">Password...</span>";
          shadow_passes = 2;
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 0";
          on-resume = "brightnessctl -r";
        }

        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }

        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }

        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
