{ config, lib, ... }:

{
  home-manager.users.cole = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        {
          output = "DP-2";
          mode = "3840x2160@240";
          position = "0x0";
          scale = 1.5;
          bitdepth = 10;
          cm = "auto";
        }
        {
          output = "HDMI-A-2";
          mode = "1680x1050@60";
          position = "2560x0";
          scale = 1;
        }
        # { output = "eDP-2"; disabled = true; }
      ];

      # config.cursor.no_hardware_cursors = true;

      workspace_rule = lib.concatLists (
        lib.genList (i: [
          {
            workspace = toString (i + 1);
            monitor = "DP-2";
          }
          {
            workspace = toString (i + 11);
            monitor = "HDMI-A-2";
          }
        ]) 10
      );

      config.animations = {
        enabled = true;
        workspace_wraparound = true;
      };

      curve =
        lib.mapAttrsToList
          (name: p: {
            _args = [
              name
              {
                type = "bezier";
                points = p;
              }
            ];
          })
          {
            easeOutQuint = [
              [
                0.23
                1
              ]
              [
                0.32
                1
              ]
            ];
            easeInOutCubic = [
              [
                0.65
                0.05
              ]
              [
                0.36
                1
              ]
            ];
            linear = [
              [
                0
                0
              ]
              [
                1
                1
              ]
            ];
            almostLinear = [
              [
                0.5
                0.5
              ]
              [
                0.75
                1.0
              ]
            ];
            quick = [
              [
                0.15
                0
              ]
              [
                0.1
                1
              ]
            ];
          };

      animation =
        map
          (
            a:
            {
              leaf = builtins.elemAt a 0;
              enabled = true;
              speed = builtins.elemAt a 1;
              bezier = builtins.elemAt a 2;
            }
            // lib.optionalAttrs (builtins.length a > 3) { style = builtins.elemAt a 3; }
          )
          [
            [
              "global"
              10
              "default"
            ]
            [
              "border"
              5.39
              "easeOutQuint"
            ]
            [
              "windows"
              4.79
              "easeOutQuint"
            ]
            [
              "windowsIn"
              4.1
              "easeOutQuint"
              "popin 87%"
            ]
            [
              "windowsOut"
              1.49
              "linear"
              "popin 87%"
            ]
            [
              "fadeIn"
              1.73
              "almostLinear"
            ]
            [
              "fadeOut"
              1.46
              "almostLinear"
            ]
            [
              "fade"
              3.03
              "quick"
            ]
            [
              "layers"
              3.81
              "easeOutQuint"
            ]
            [
              "layersIn"
              4
              "easeOutQuint"
              "fade"
            ]
            [
              "layersOut"
              1.5
              "linear"
              "fade"
            ]
            [
              "fadeLayersIn"
              1.79
              "almostLinear"
            ]
            [
              "fadeLayersOut"
              1.39
              "almostLinear"
            ]
            [
              "workspaces"
              1.94
              "almostLinear"
              "fade"
            ]
            [
              "workspacesIn"
              1.21
              "almostLinear"
              "fade"
            ]
            [
              "workspacesOut"
              1.94
              "almostLinear"
              "fade"
            ]
          ];

      # config.experimental.xx_color_management_v4 = true;
    };
  };
}
