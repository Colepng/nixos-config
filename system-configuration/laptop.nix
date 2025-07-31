# Nix os module that contains all configuartion rust toolings
{ config, pkgs, ... }:

{
  services.thermald.enable = true;
}
