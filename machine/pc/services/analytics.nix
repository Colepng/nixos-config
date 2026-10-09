{ config, ... }:
{
  services = {
    beszel = {
      hub.enable = true;

      agent = {
        enable = true;
        environmentFile = config.age.secrets.beszel.path;
        environment = {
          HUB_URL = "http://127.0.0.1:8090";
          KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDYtycokKvGEE6IhdigXzll9HoFJGGVj4aJBD7olZh/h";
          EXTRA_FILESYSTEMS = "/media__Media,/home/cole/server-drive__ServerDrive,/mnt/Games__Games";
        };

        smartmon = {
          enable = true;
          deviceAllow = [
            "/dev/sda"
            "/dev/sdb"
            "/dev/nvme0n1"
            "/dev/nvme1n1"
          ];
        };
      };
    };
  };
}
