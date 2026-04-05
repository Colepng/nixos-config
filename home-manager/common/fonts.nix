# Nix module for managing fonts
{ pkgs, lib, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
