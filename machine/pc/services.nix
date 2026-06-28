{ ... }:
{
  services = {
    caddy = {
      enable = true;
      virtualHosts."photos.colepng.com".extraConfig = ''
        reverse_proxy localhost:2283
      '';

      virtualHosts."jellyfin.colepng.com".extraConfig = ''
        reverse_proxy localhost:8096
      '';
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
