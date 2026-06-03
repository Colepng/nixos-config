# Nix module for managing typst
{ pkgs, inputs, ... }:

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
    ++ typstPackages
    ++ [ inputs.typst.packages.${pkgs.system}.default ];
}
