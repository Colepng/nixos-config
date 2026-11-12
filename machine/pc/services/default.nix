{
  imports = [
    ./analytics.nix
    ./backups.nix
    ./books.nix
    ./caddy.nix
    ./cloudflare-dns.nix
    ./dns.nix
    ./hedgedoc.nix
    ./jellyfin.nix
    ./taskchampion.nix
    ./torrenting.nix
  ];

  services.fail2ban.enable = true;
}
