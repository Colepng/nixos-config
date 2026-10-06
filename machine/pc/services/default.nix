{
  imports = [
    ./backups.nix
    ./books.nix
    ./caddy.nix
    ./dns.nix
    ./hedgedoc.nix
    ./jellyfin.nix
    ./taskchampion.nix
    ./torrenting.nix
  ];

  services.fail2ban.enable = true;
}
