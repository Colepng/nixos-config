# Nix module for managing typst
{ pkgs, lib, ... }:

let
  typstPackages = with pkgs.typstPackages; [

    colorful-boxes
  ];
in
{

  home.packages =
    with pkgs;
    [
      tinymist
      websocat
    ]
    ++ typstPackages;
}
