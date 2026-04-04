{
  config,
  lib,
  pkgs,
  ...
}:

{
  hardware.bluetooth.enable = true;
  # Enable OpenTabletDriver
  hardware.opentabletdriver.enable = true;

  # Required by OpenTabletDriver
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];
  networking.hostName = "framework";
}
