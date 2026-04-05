{ ... }:
{
  services = {
    polkit-gnome.enable = true;

    udiskie.enable = true;

    poweralertd.enable = true;

    syncthing = {
      enable = true;
      tray.enable = true;
    };
  };
}
