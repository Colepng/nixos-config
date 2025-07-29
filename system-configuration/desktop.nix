# Nix os module that contains all configuartion for the system wide desktop expreince, login manager, auto login, DE/WM, etc
{ config, pkgs, ... }:

{
  # Enable the plasma Desktop Environment.
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "hyprland";
  programs.hyprland.enable = true;

  environment.systemPackages = [ pkgs.kitty ];

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "cole";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
}
