# Nix os module that configures hyprland for users
{
  lib,
  config,
  pkgs,
  ...
}:
let
  lua = lib.generators.mkLuaInline;
  toLua = lib.generators.toLua { };

  dsp = expr: lua "hl.dsp.${expr}";
  exec = cmd: dsp "exec_cmd(${toLua cmd})";

  bind = keys: action: {
    _args = [
      keys
      action
    ];
  };
  bindl = keys: action: {
    _args = [
      keys
      action
      { locked = true; }
    ];
  };
  bindm = keys: action: {
    _args = [
      keys
      action
      { mouse = true; }
    ];
  };

  mainMod = "SUPER";
  altMod = "ALT";
  altMainMod = "SUPER + SHIFT";
  altAltMainMod = "ALT + SHIFT";

  shot =
    mode:
    exec "hyprshot -z -o ~/Pictures/screenshots -f screenshot-$(date +%Y-%m-%d_%H-%M-%S).png -m ${mode}";

  autostart = [
    "swww restore"
    "iio-hyprland --left-master"
    "nm-applet"
    "wl-paste --watch cliphist store"
    "squeekboard"
    "syshud"
    "waybar"
  ];
in
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

  services.awww.enable = true;
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
    configType = "lua";

    settings = {
      monitor = lib.mkDefault [
        {
          output = "eDP-1";
          mode = "preferred";
          position = "auto";
          scale = 1.25;
        }
      ];

      on = {
        _args = [
          "hyprland.start"
          (lua "function()\n${lib.concatMapStrings (c: "  hl.exec_cmd(${toLua c})\n") autostart}end")
        ];
      };

      config = {
        xwayland.force_zero_scaling = true;

        general = {
          resize_on_border = true;
          # col = {
          #   active_border = { colors = [ "rgba(33ccffee)" "rgba(00ff99ee)" ]; angle = 45; };
          #   inactive_border = "rgba(595959aa)";
          # };
        };

        dwindle.preserve_split = true;

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

        animations.enabled = lib.mkDefault false;

        misc = {
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        input.touchpad.natural_scroll = true;
        input.tablet.output = "eDP-1";

        gestures.workspace_swipe_cancel_ratio = 0.15;
      };

      gesture = {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      };

      window_rule = lib.mkDefault [
        # ignore maximize requests from apps. you'll probably like this.
        {
          name = "suppress-maximize";
          match.class = ".*";
          suppress_event = "maximize";
        }

        # fix some dragging issues with xwayland
        {
          name = "fix-xwayland-drags";
          match = {
            class = "^$";
            title = "^$";
            xwayland = true;
            float = true;
            fullscreen = false;
            pin = false;
          };
          no_focus = true;
        }

        {
          name = "spotify-ws";
          match.class = "spotify";
          workspace = "11 silent";
        }
        {
          name = "discord-ws";
          match.class = "discord";
          workspace = "13 silent";
        }
        {
          name = "discord-ws";
          match.class = "vesktop";
          workspace = "13 silent";
        }
        {
          name = "fastmail-ws";
          match.class = "fastmail";
          workspace = "7 silent";
        }
        {
          name = "steam-2483190-tile";
          match.class = "steam_app_2483190";
          float = false;
        }
      ];

      bind = [
        # bindl
        (bindl "${mainMod} + Delete" (dsp "exit()"))

        # audio keys
        (bindl "XF86AudioRaiseVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
        (bindl "XF86AudioLowerVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
        (bindl "XF86AudioMute" (exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

        # brightness keys
        (bindl "XF86MonBrightnessUp" (exec "brightnessctl -e4 -n2 set 5%+"))
        (bindl "XF86MonBrightnessDown" (exec "brightnessctl -e4 -n2 set 5%-"))

        # media control keys
        (bindl "XF86AudioNext" (exec "playerctl next"))
        (bindl "XF86AudioPause" (exec "playerctl play-pause"))
        (bindl "XF86AudioPlay" (exec "playerctl play-pause"))
        (bindl "XF86AudioPrev" (exec "playerctl previous"))

        # hyprland interaction
        (bind "${mainMod} + Q" (dsp "window.close()"))
        (bind "${mainMod} + F" (dsp ''window.float({ action = "toggle" })''))
        (bind "${mainMod} + M" (dsp "window.fullscreen()"))
        (bind "${altMainMod} + M" (dsp ''window.fullscreen({ mode = "maximized" })''))
        # SUPER+SHIFT+P was bound twice (pin + hyprshot window); pin disabled
        # (bind "${mainMod} + SHIFT + P" (dsp "window.pin()"))
        (bind "${mainMod} + J" (dsp ''layout("togglesplit")''))
        (bind "${mainMod} + X" (dsp "workspace.toggle_special()"))

        # apps
        (bind "${mainMod} + Return" (exec "foot"))
        (bind "${altMod} + C" (exec ''firefox --new-tab "https://app.fastmail.com/calendar/week/"''))
        (bind "${altMod} + M" (exec ''firefox --new-tab "https://app.fastmail.com/mail/inbox"''))
        (bind "${mainMod} + Space" (exec "fuzzel"))

        # utils
        (bind "${mainMod} + P" (shot "region"))
        (bind "${altMainMod} + P" (shot "window"))
        (bind "${altMod} + P" (shot "output"))
        (bind "${mainMod} + V" (exec ''bash -c "cliphist list | rofi -dmenu | cliphist decode | wl-copy"''))

        # mouse
        (bindm "${mainMod} + mouse:272" (dsp "window.drag()"))
        (bindm "${mainMod} + mouse:273" (dsp "window.resize()"))
      ]
      # focus / swap
      ++ lib.concatLists (
        lib.mapAttrsToList
          (key: dir: [
            (bind "${mainMod} + ${key}" (dsp ''focus({ direction = "${dir}" })''))
            (bind "${altMod} + ${key}" (dsp ''window.swap({ direction = "${dir}" })''))
          ])
          {
            A = "left";
            D = "right";
            W = "up";
            S = "down";
          }
      )
      # workspaces: $mod + [shift +] {1..9} to [move to] workspace {1..9}, ALT layer -> 11..19
      ++ lib.concatLists (
        lib.genList (
          i:
          let
            ws = i + 1;
            key = "code:1${toString i}";
          in
          [
            (bind "${mainMod} + ${key}" (dsp "focus({ workspace = ${toString ws} })"))
            (bind "${altMainMod} + ${key}" (dsp "window.move({ workspace = ${toString ws} })"))
            (bind "${altMod} + ${key}" (dsp "focus({ workspace = ${toString (ws + 10)} })"))
            (bind "${altAltMainMod} + ${key}" (dsp "window.move({ workspace = ${toString (ws + 10)} })"))
          ]
        ) 9
      );
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
