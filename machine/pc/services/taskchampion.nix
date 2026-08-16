{ ... }:
{
  services = {
    taskchampion-sync-server = {
      enable = true;
      openFirewall = true;
      port = 8081;
    };
  };
}
