# Nix os module that configures hyprland for users
{ config, pkgs, ... }:

{
  # needed for termainl inside hyprland
  programs.kitty.enable = true;
  wayland.windowmManager.hyprland = {
    enable = true;
    settinngs = {
    "$mod" = "ALT";
    bind =
      [
        "$mod, F, exec, firefox"
        ", Print, exec, grimblast copy area"
        "$mod, Q, exec, kitty"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
    };
  };

  # Set env for electron apps to use wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
