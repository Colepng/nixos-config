{ config, ... }:
{
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.age.secrets.cloudflare-ddns.path;
    domains = [
      "colepng.com"
      "*.colepng.com"
    ];
    proxied = false;
  };
}
