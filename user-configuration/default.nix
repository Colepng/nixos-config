{ caelestia-shell, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./fonts.nix
    ./typst.nix
  ];

  home.packages = [ caelestia-shell.packages.${pkgs.system}.caelestia-shell ];
}
