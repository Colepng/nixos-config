{
  config,
  lib,
  pkgs,
  ...
}:

{
  hardware.bluetooth.enable = true;

  networking.hostName = "framework";
}
