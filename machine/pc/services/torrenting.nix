{ lib, ... }:
{
  users.groups.media = { };

  services = {
    qbittorrent = {
      enable = true;
      openFirewall = true;
      group = "media";
    };

    sonarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };

    radarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    flaresolverr = {
      enable = true;
      openFirewall = true;
    };
  };

  systemd.services.sonarr.serviceConfig.UMask = lib.mkForce "0002";
  systemd.services.radarr.serviceConfig.UMask = lib.mkForce "0002";
  systemd.services.qbittorrent.serviceConfig.UMask = lib.mkForce "0002";

  systemd.services.qbittorrent.vpnConfinement = {
    enable = true;
    vpnNamespace = "qbit";
  };

  systemd.services.prowlarr.vpnConfinement = {
    enable = true;
    vpnNamespace = "qbit";
  };

  systemd.services.flaresolverr.vpnConfinement = {
    enable = true;
    vpnNamespace = "qbit";
  };

  systemd.services.radarr.vpnConfinement = {
    enable = true;
    vpnNamespace = "qbit";
  };

  systemd.services.sonarr.vpnConfinement = {
    enable = true;
    vpnNamespace = "qbit";
  };

  # Define VPN network name space
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
      {
        from = 9696;
        to = 9696;
      }
      {
        from = 8191;
        to = 8191;
      }
      {
        from = 8989;
        to = 8989;
      }
      {
        from = 7878;
        to = 7878;
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
