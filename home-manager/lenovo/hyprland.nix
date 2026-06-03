# Nix os module that configures hyprland for users
{
  lib,
  config,
  pkgs,
  ...
}:

{
  # Pkgs used by hyprland or my hyprland config
  home.packages = with pkgs; [
    waybar
    playerctl
    brightnessctl
    iio-hyprland
    jq # needed by iio-hyprland
    nwg-drawer
    hyprshot
    wl-clipboard
    imagemagick
    syshud
    squeekboard
  ];

  services.mako = {
    enable = false;
    settings = {
      "actionable=true" = {
        anchor = "top-left";
      };
      actions = true;
      anchor = "top-right";
      # background-color = "#000000";
      # border-color = "#FFFFFF";
      border-radius = 5;
      default-timeout = 3000;
      # font = "monospace 12";
      height = 100;
      icons = true;
      ignore-timeout = false;
      layer = "top";
      margin = 10;
      markup = true;
      width = 300;
    };
  };

  services.swww.enable = true;
  services.cliphist = {
    enable = true;
    extraOptions = [
      "--max items"
      "100000"
    ];
  };

  # needed for termainl inside hyprland
  programs.kitty.enable = true;
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        termainl = "/etc/profiles/per-user/cole/bin/foot";
        layer = "overlay";
        inner-pad = 15;
        fields = "filename,name";
        width = 15;
      };
    };
  };

  wayland.windowManager.hyprland = {
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    enable = true;

    plugins = lib.mkDefault [
    ];

    settings = {
      monitor = lib.mkDefault "eDP-1,preferred,auto,1.25";

      exec-once = [
        "swww restore"
        "iio-hyprland --left-master"
        "nm-applet"
        "wl-paste --watch cliphist store"
        "squeekboard"
        "syshud"
        "waybar"
      ];

      xwayland.force_zero_scaling = true;

      general = {
        resize_on_border = true;
        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        # "col.inactive_border" = "rgba(595959aa)";
      };

      dwindle = {
        preserve_split = true;
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          # color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      animations = lib.mkDefault {
        enabled = false;
      };

      misc = {
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };

      input.touchpad.natural_scroll = true;
      input.tablet.output = "eDP-1";

      gestures = {
        workspace_swipe_cancel_ratio = 0.15;
      };

      gesture = {
        "gesture" = "3, horizontal, workspace";
      };

      windowrule = lib.mkDefault [
        # ignore maximize requests from apps. you'll probably like this.
        "suppress_event maximize, match:class .*"

        # fix some dragging issues with xwayland
        "no_focus 1, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0"

        "workspace 11 silent, match:class spotify"
        "workspace 14 silent, match:class discord"
        "workspace 7 silent, match:class fastmail"
        "match:class steam_app_2483190, float off"
      ];

      plugin.touch_gestures = {
        # the default sensitivity is probably too low on tablet screens,
        # i recommend turning it up to 4.0
        sensitivity = 4.0;

        # must be >= 3
        workspace_swipe_fingers = 3;

        # switching workspaces by swiping from an edge, this is separate from workspace_swipe_fingers
        # and can be used at the same time
        # possible values: l, r, u, or d
        # to disable it set it to anything else
        workspace_swipe_edge = "d";

        # in milliseconds
        long_press_delay = 400;

        # resize windows by long-pressing on window borders and gaps.
        # if general:resize_on_border is enabled, general:extend_border_grab_area is used for floating
        # windows
        resize_on_border_long_press = true;

        # in pixels, the distance from the edge that is considered an edge
        edge_margin = 10;

        # emulates touchpad swipes when swiping in a direction that does not trigger workspace swipe.
        # only triggers when finger count is equal to workspace_swipe_fingers
        #
        # might be removed in the future in favor of event hooks
        emulate_touchpad_swipe = false;

        experimental = {
          # send proper cancel events to windows instead of hacky touch_up events,
          # not recommended as it crashed a few times, once it's stabilized i'll make it the default
          send_cancel = 0;
        };

        hyprgrass-bind = [
          # swipe left from right edge
          " , edge:r:l, workspace, m+1"
          # swipe left from right edge
          " , edge:l:r, workspace, m-1"

          # # swipe up from bottom edge
          # ", edge:d:u, exec, busctl call --user sm.puri.osk0 /sm/puri/osk0 sm.puri.osk0 setvisible b true"
          # swipe down from right edge
          ", edge:r:d, exec, busctl call --user sm.puri.osk0 /sm/puri/osk0 sm.puri.osk0 setvisible b true"

          ", edge:u:d, exec, nwg-drawer"

          # swipe down with 4 fingers
          ", swipe:3:u, killactive"

          ", edge:u:r, exec, hyprshot -z -o ~/pictures/screenshots -f screenshot-\"$(date +%f-%x)\".png -m region"
        ];

        hyprgrass-bindm = [
          # longpress can trigger mouse binds:
          # " , longpress:2, movewindow"
          # " , longpress:3, resizewindow"
        ];
      };

      "$mainmod" = "super";
      "$altmod" = "alt";
      "$altmainmod" = "super + shift";
      "$altaltmainmod" = "super + alt";

      bindl = [
        "$mainmod, delete, exit"

        # audio keys
        ",xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",xf86audiomute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        # ",xf86audiomutemic, exec, wpctl set-mute -l 1 @DEFAULT_AUDIO_SINK@ toggle"

        # brightness keys
        ",xf86monbrightnessup, exec, brightnessctl -e4 -n2 set 5%+"
        ",xf86monbrightnessdown, exec, brightnessctl -e4 -n2 set 5%-"

        # media control keys
        ",xf86audionext, exec, playerctl next"
        ",xf86audiopause, exec, playerctl play-pause"
        ",xf86audioplay, exec, playerctl play-pause"
        ",xf86audioprev, exec, playerctl previous"
      ];

      bind = [
        # hyprland interaction
        "$mainmod, q, killactive"
        "$mainmod, f, togglefloating"
        "$mainmod, m, fullscreen"
        "$altmainmod, m, fullscreen, 1"
        "$mainmod shift, p, pin"
        "$mainmod, j, layoutmsg, togglesplit"
        "$mainmod, x, togglespecialworkspace"

        "$mainmod, l, global, caelestia:lock"

        # window movment
        # move focus with mainmod + arrow keys,
        "$mainmod, a, movefocus, l"
        "$mainmod, d, movefocus, r"
        "$mainmod, w, movefocus, u"
        "$mainmod, s, movefocus, d"

        "$altmod, a, swapwindow, l"
        "$altmod, d, swapwindow, r"
        "$altmod, w, swapwindow, u"
        "$altmod, s, swapwindow, d"

        # apps
        "$mainmod, return, exec, foot"
        "$altmod, c, exec, firefox --new-tab \"https://app.fastmail.com/calendar/week/\""
        "$altmod, m, exec, firefox --new-tab \"https://app.fastmail.com/mail/inbox\""

        # utils
        "$mainmod, p, exec, hyprshot -z -o ~/pictures/screenshots -f screenshot-\"$(date +%f-%x)\".png -m region"
        "$altmainmod, p, exec, hyprshot -z -o ~/pictures/screenshots -f screenshot-\"$(date +%f-%x)\".png -m window"
        "$altmod, p, exec, -m window > ~/pictures/screenshots/screenshot-\"$(date +%f-%x)\".png -m output"

        "$mainmod, v, exec, ~/documents/temp/cliphist-fuzzel-img"
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
              "$mainmod, code:1${toString i}, workspace, ${toString ws}"
              "$altmainmod, code:1${toString i}, movetoworkspace, ${toString ws}"
              "$altmod, code:1${toString i}, workspace, ${toString (ws + 10)}"
              "$altaltmainmod, code:1${toString i}, movetoworkspace, ${toString (ws + 10)}"
            ]
          ) 9
        )
      )
      ++ (
        if config.programs.caelestia.enable then
          [ "$mainmod, space, global, caelestia:launcher" ]
        else
          [
            "$mainmod, space, exec, fuzzel"
          ]
      );

      bindm = [
        "$mainmod, mouse:272, movewindow"
        "$mainmod, mouse:273, resizewindow"
      ];
    };
  };

  programs.hyprlock = {
    enable = false;
    settings = {
      general = {
        hide_cursor = false;
        ignore_empty_input = true;
      };

      animations = {
        enabled = true;
        fade_in = {
          duration = 300;
          bezier = "easeoutquint";
        };
        fade_out = {
          duration = 300;
          bezier = "easeoutquint";
        };
      };

      # background = [
      #   {
      #     path = "screenshot";
      #     blur_passes = 3;
      #     blur_size = 8;
      #   }
      # ];

      # input-field = [
      #   {
      #     size = "200, 50";
      #     position = "0, -80";
      #     monitor = "";
      #     dots_center = true;
      #     fade_on_empty = false;
      #     # font_color = "rgb(202, 211, 245)";
      #     # inner_color = "rgb(91, 96, 120)";
      #     # outer_color = "rgb(24, 25, 38)";
      #     outline_thickness = 5;
      #     placeholder_text = "<span foreground=\"##cad3f5\">password...</span>";
      #     shadow_passes = 2;
      #   }
      # ];
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

        # {
        #   timeout = 600;
        #   on-timeout = "systemctl suspend";
        # }
      ];
    };
  };

  dconf.settings = {
    "sm/puri/osk0" = {
      layout-shape-changes-to-fit-panel = false;
      scale-in-horizontal-screen-orientation = 10.0;
      scale-in-vertical-screen-orientation = 10.0;
    };
  };
}
