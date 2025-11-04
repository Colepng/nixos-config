{ caelestia-shell, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./fonts.nix
    ./typst.nix
    ./caelestia.nix
  ];
}
