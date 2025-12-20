{ config, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        layer = "top";

        modules-left = [
          "custom/logo"
          "disk"
          "custom/powerDraw"
          "cpu"
          "memory"
          "custom/media"
          "tray"
        ];

        modules-center = [ "hyprland/workspaces" ];

        modules-right = [
          "backlight"
          "pulseaudio"
          "clock"
          "battery"
          "custom/power"
        ];

        reload_style_on_change = true;

        backlight = {
          format = " {}%";
          interval = 1;
          on-scroll-down = "light -U 5";
          on-scroll-up = "light -A 5";
          tooltip = false;
        };
        battery = {
          format = "{icon}  {capacity}%";
          format-alt = "{time} {icon}";
          format-charging = " {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          format-plugged = " {capacity}%";
          states = {
            critical = 20;
            good = 95;
            warning = 30;
          };
        };
        clock = {
          format = "{:%I:%M %p %a %b %d}";
        };
        cpu = {
          format = " {}%";
          interval = 15;
          max-length = 10;
        };
        "custom/logo" = {
          format = " ";
          tooltip = false;
        };
        # "custom/media" = {
        #   escape = true;
        #   exec = "$HOME/.config/system_scripts/mediaplayer.py 2> /dev/null";
        #   format = "{icon} {}";
        #   format-icons = {
        #     default = " ";
        #     spotify = " ";
        #   };
        #   interval = 30;
        #   max-length = 20;
        #   on-click = "playerctl play-pause";
        #   return-type = "json";
        # };
        "custom/power" = {
          format = "⏻ ";
          on-click = "wlogout --protocol layer-shell -b 5 -T 400 -B 400";
        };
        # "custom/powerDraw" = {
        #   exec = "~/.config/waybar/scripts/power.sh";
        #   format = "{}";
        #   interval = 1;
        #   return-type = "json";
        # };
        # "custom/weather" = {
        #   exec = "~/.config/waybar/scripts/weather.sh";
        #   format = "{}";
        #   interval = 10;
        #   on-click = "firefox https://wttr.in";
        #   return-type = "json";
        # };
        disk = {
          format = "  {percentage_used}%";
          interval = 30;
          path = "/";
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            active = "";
            default = "";
          };
          persistent-workspaces = {
            DP-2 = [
              1
              2
              3
              4
              5
            ];
            HDMI-A-1 = [
              11
              12
              13
              14
              15
            ];
            eDP-2 = [
              1
              2
              3
              4
              5
            ];
          };
        };
        memory = {
          format = " {}%";
          interval = 30;
          max-length = 10;
        };
        network = {
          format-ethernet = "";
          format-wifi = "  {essid}";
          tooltip = false;
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          format-muted = "{icon} {volume}%";
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          scroll-step = 5;
          tooltip = false;
        };

        temperature = {
          critical-threshold = 95;
          format = " {temperatureC}°C";
          format-critical = " {temperatureC}°C";
          interval = 1;
          on-click = "foot btop";
        };
        tray = {
          icon-size = 18;
          spacing = 10;
        };
      };
    };

    style = ''
          * {
      	border: none;
      	border-radius: 10;
          font-family: "JetbrainsMono Nerd Font" ;
      	font-size: 15px;
      	min-height: 10px;
      }

      window#waybar {
      	background: transparent;
      }

      window#waybar.hidden {
      	opacity: 0.2;
      }

      #window {
      	margin-top: 6px;
      	padding-left: 10px;
      	padding-right: 10px;
      	border-radius: 10px;
      	transition: none;
          color: transparent;
      	background: transparent;
      }
      #tags {
      	margin-top: 6px;
      	margin-left: 12px;
      	font-size: 4px;
      	margin-bottom: 0px;
      	border-radius: 10px;
      	background: #161320;
      	transition: none;
      }

      #tags button {
      	transition: none;
      	color: #B5E8E0;
      	background: transparent;
      	font-size: 16px;
      	border-radius: 2px;
      }

      #tags button.occupied {
      	transition: none;
      	color: #F28FAD;
      	background: transparent;
      	font-size: 4px;
      }

      #tags button.focused {
      	color: #ABE9B3;
          border-top: 2px solid #ABE9B3;
          border-bottom: 2px solid #ABE9B3;
      }

      #tags button:hover {
      	transition: none;
      	box-shadow: inherit;
      	text-shadow: inherit;
      	color: #FAE3B0;
          border-color: #E8A2AF;
          color: #E8A2AF;
      }

      #tags button.focused:hover {
          color: #E8A2AF;
      }

      #network {
      	margin-top: 6px;
      	margin-left: 8px;
      	padding-left: 10px;
      	padding-right: 10px;
      	margin-bottom: 0px;
      	border-radius: 10px;
      	transition: none;
      	color: #161320;
      	background: #bd93f9;
      }

      #pulseaudio {
      	margin-top: 6px;
      	margin-left: 8px;
      	padding-left: 10px;
      	padding-right: 10px;
      	margin-bottom: 0px;
      	border-radius: 10px;
      	transition: none;
      	color: #1A1826;
      	background: #FAE3B0;
      }

      #battery {
      	margin-top: 6px;
      	margin-left: 8px;
      	padding-left: 10px;
      	padding-right: 10px;
      	margin-bottom: 0px;
      	border-radius: 10px;
      	transition: none;
      	color: #161320;
      	background: #B5E8E0;
      }

      #battery.charging, #battery.plugged {
      	color: #161320;
          background-color: #B5E8E0;
      }

      #battery.critical:not(.charging) {
          background-color: #B5E8E0;
          color: #161320;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      @keyframes blink {
          to {
              background-color: #BF616A;
              color: #B5E8E0;
          }
      }

      #backlight {
      	margin-top: 6px;
      	margin-left: 8px;
      	padding-left: 10px;
      	padding-right: 10px;
      	margin-bottom: 0px;
      	border-radius: 10px;
      	transition: none;
      	color: #161320;
      	background: #F8BD96;
      }
      #clock {
      	margin-top: 6px;
      	margin-left: 8px;
      	padding-left: 10px;
      	padding-right: 10px;
      	margin-bottom: 0px;
      	border-radius: 10px;
      	transition: none;
      	color: #161320;
      	background: #ABE9B3;
      	/*background: #1A1826;*/
      }

      #temperature {
      	margin-top: 6px;
      	margin-left: 0px;
      	padding-left: 10px;
      	margin-bottom: 0px;
      	padding-right: 10px;
          border-radius: 0px 10px 10px 00px;
      	transition: none;
      	color: #161320;
      	background: #DDB6F2;
      }

      #memory {
      	margin-top: 6px;
      	margin-left: 0px;
      	padding-left: 10px;
      	margin-bottom: 0px;
      	padding-right: 10px;
          border-radius: 0px 10px 10px 00px;
      	transition: none;
      	color: #161320;
      	background: #DDB6F2;
      }

      #cpu, #custom-powerDraw {
      	margin-top: 6px;
      	margin-left: 0px;
      	padding-left: 10px;
      	margin-bottom: 0px;
      	padding-right: 10px;
      	border-radius: 0px;
      	transition: none;
      	color: #161320;
      	background: #DDB6F2;
      }

      #disk {
          margin-top: 6px;
          margin-left: 8px;
      	padding-left: 10px;
      	margin-bottom: 0px;
      	padding-right: 10px;
          border-radius: 10px 0px 0px 10px;
      	transition: none;
      	color: #161320;
      	background: #DDB6F2;
      }

      #custom-weather {
      	margin-top: 6px;
      	margin-left: 8px;
      	padding-left: 10px;
      	margin-bottom: 0px;
      	padding-right: 10px;
      	border-radius: 10px;
      	transition: none;
      	color: #161320;
      	background: #96CDFB;
      }

      #tray {
      	margin-top: 6px;
      	margin-left: 8px;
      	padding-left: 10px;
      	margin-bottom: 0px;
      	padding-right: 10px;
      	border-radius: 10px;
      	transition: none;
      	color: #B5E8E0;
      	background: #161320;
      }

      #custom-logo {
      	font-size: 24px;
      	margin-top: 6px;
      	margin-left: 8px;
      	padding-left: 10px;
      	padding-right: 5px;
      	border-radius: 10px;
      	transition: none;
          color: #89DCEB;
          background: #161320;
      }

      #custom-power {
      	font-size: 20px;
      	margin-top: 6px;
      	margin-left: 8px;
      	margin-right: 8px;
      	padding-left: 10px;
      	padding-right: 5px;
      	margin-bottom: 0px;
      	border-radius: 10px;
      	transition: none;
      	color: #161320;
      	background: #F28FAD;
      }

      #custom-wallpaper {
      	margin-top: 6px;
      	margin-left: 8px;
      	padding-left: 10px;
      	padding-right: 10px;
      	margin-bottom: 0px;
      	border-radius: 10px;
      	transition: none;
      	color: #161320;
      	background: #C9CBFF;
      }

      #custom-updates {
      	margin-top: 6px;
      	margin-left: 8px;
      	padding-left: 10px;
      	padding-right: 10px;
      	margin-bottom: 0px;
      	border-radius: 10px;
      	transition: none;
      	color: #161320;
      	background: #E8A2AF;
      }

      #custom-media {
      	margin-top: 6px;
      	margin-left: 8px;
      	padding-left: 10px;
      	padding-right: 10px;
      	margin-bottom: 0px;
      	border-radius: 10px;
      	transition: none;
      	color: #161320;
      	background: #F2CDCD;
      }
    '';
  };
}
