{ ... }:
{
  services = {
    shelfmark = {
      enable = true;
      environment = {
        TZ = "America/Toronto";
        INGEST_DIR = "/media/calibre-ingest";
        CWA_DB_PATH = "/var/lib/cwa/config/app.db";
      };
    };
  };

  systemd.services.shelfmark.serviceConfig = {
    ReadWritePaths = [
      "/media/calibre-ingest"
      "/media/Downloading/books"
    ];
  };
}
