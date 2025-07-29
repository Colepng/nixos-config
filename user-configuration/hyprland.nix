# Nix os module that configures hyprland for users
{ config, pkgs, ... }:

{
  # Pkgs used by hyprland or my hyprland config
  home.packages = with pkgs; [
    fuzzel
    foot
    waybar
  ];

  services.mako.enable = true;

  # needed for termainl inside hyprland
  programs.kitty.enable = true;

  wayland.windowManager.hyprland = {
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    enable = true;
    systemd.variables = [ "--all" ];
    settings = {
      monitor = ",preferred,auto,1.5";

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

      "$mainMod" = "SUPER";
      "$altMod" = "ALT";
      "$altMainMod" = "SUPER + SHIFT";
      "$altAltMainMod" = "SUPER + ALT";

      bindl = [
	"$mainMod, Delete, exit"
      ];

      bind =
        [
	  # Hyprland interaction
	  "$mainMod, Q, killactive"
	  "$mainMod, F, togglefloating"
	  "$mainMod, M, fullscreen"
	  "$AltMainMod, M, fullscreen, 1"
	  "$mainMod SHIFT, P, pin"
	  "$mainMod, J, togglesplit"
	  "$mainMod, X, togglespecialworkspace"
	  
	  # Apps
	  "$mainMod, Space, exec, fuzzel"
	  "$mainMod, Return, exec, foot"
	  "$altMod, C, exec, firefox --new-tab \"https://app.fastmail.com/calendar/week/\""
	  "$altMod, M, exec, firefox --new-tab \"https://app.fastmail.com/mail/Inbox\""
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
              let ws = i + 1;
              in [
                "$mainMod, code:1${toString i}, workspace, ${toString ws}"
                "$altMainMod, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
  };

  # Set env for electron apps to use wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
