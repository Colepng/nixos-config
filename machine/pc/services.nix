{ ... }:
{
  services = {
    caddy = {
      enable = true;
      virtualHosts."photos.colepng.com".extraConfig = ''
        reverse_proxy localhost:2283
      '';
    };
  };
}
