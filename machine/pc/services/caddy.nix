{ ... }:
{
  services.caddy = {
    enable = true;

    virtualHosts."photos.colepng.com".extraConfig = ''
      reverse_proxy localhost:2283
    '';

    virtualHosts."immich.colepng.com".extraConfig = ''
      reverse_proxy localhost:2283
    '';

    virtualHosts."jellyfin.colepng.com".extraConfig = ''
      reverse_proxy localhost:8096
    '';

    virtualHosts."qbittorrent.colepng.com".extraConfig = ''
      reverse_proxy localhost:8080
    '';

    virtualHosts."qbit.colepng.com".extraConfig = ''
      reverse_proxy 192.168.15.1:8080
    '';

    virtualHosts."dawarich.colepng.com".extraConfig = ''
      reverse_proxy localhost:3000
    '';

    virtualHosts."airtail.colepng.com".extraConfig = ''
      reverse_proxy localhost:3001
    '';

    virtualHosts."seerr.colepng.com".extraConfig = ''
      reverse_proxy localhost:5055
    '';
  };
}
