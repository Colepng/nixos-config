# Nix os module that contains all configuartion for the system wide desktop expreince, login manager, auto login, DE/WM, etc
{ ... }:

{
  services.displayManager.defaultSession = "niri";
  programs.niri.enable = true;
}
