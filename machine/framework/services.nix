{ config, ... }:
{
  services = {
    blueman.enable = true;

    iio-niri.enable = true;

    beszel.agent = {
      enable = true;
      environmentFile = config.age.secrets.beszel.path;
      environment = {
        HUB_URL = "https://beszel.colepng.com";
        KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDYtycokKvGEE6IhdigXzll9HoFJGGVj4aJBD7olZh/h";
      };

      smartmon = {
        enable = true;
        deviceAllow = [
          "/dev/nvme0n1"
        ];
      };
    };
  };
}
