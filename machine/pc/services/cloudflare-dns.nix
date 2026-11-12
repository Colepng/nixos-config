{ config, ... }:
{
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.age.secrets.cloudflare.path;
    domains = [
      "airtail.colepng.com"
      "beszel.colepng.com"
      "books.colepng.com"
      "*.colepng.com"
      "crafty.colepng.com"
      "dawarich.colepng.com"
      "dawarich-eli.colepng.com"
      "dns.colepng.com"
      "eli.colepng.com"
      "files.colepng.com"
      "grafana.colepng.com"
      "hedgedoc.colepng.com"
      "home.colepng.com"
      "immich.colepng.com"
      "iqbit.colepng.com"
      "jellyfin.colepng.com"
      "mc.colepng.com"
      "minecraft.colepng.com"
      "nextcloud-aio.colepng.com"
      "obsidian.colepng.com"
      "photos.colepng.com"
      "print.colepng.com"
      "prowlarr.colepng.com"
      "qbit.colepng.com"
      "qbittorrent.colepng.com"
      "radarr.colepng.com"
      "seerr.colepng.com"
      "shelfmark.colepng.com"
      "sonarr.colepng.com"
      "ssh.colepng.com"
      "taskchampion.colepng.com"
      "taskwarrior.colepng.com"
    ];
    proxied = false;
  };
}
