{
  imports = [
    ./backups.nix
    ./caddy.nix
    ./dns.nix
    ./jellyfin.nix
    ./torrenting.nix
  ];

  services.fail2ban.enable = true;
}
