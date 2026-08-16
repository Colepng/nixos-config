{ ... }:
{
  services.qbittorrent = {
    enable = true;
    openFirewall = true;
  };

  systemd.services.qbittorrent.vpnConfinement = {
    enable = true;
    vpnNamespace = "qbit";
  };

  # Define VPN network namespace
  vpnNamespaces.qbit = {
    enable = true;
    wireguardConfigFile = "/home/cole/wg0.conf";
    accessibleFrom = [
      "10.0.0.0/24"
      "192.168.0.0/24"
    ];
    portMappings = [
      {
        from = 8080;
        to = 8080;
      }
    ];
    openVPNPorts = [
      {
        port = 16834;
        protocol = "both";
      }
    ];
  };
}
