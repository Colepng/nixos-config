{
  lib,
  pkgs,
  config,
  ...
}:
{
  services.restic.backups = {
    immich = {
      backupPrepareCommand = ''
        cd /home/cole/server-drive/home/cole/immich
        \${lib.getExe pkgs.docker} exec -t immich_postgres pg_dumpall --clean --if-exists --username=postgres > postgres_dump
        \${lib.getExe pkgs.docker} compose stop
      '';
      backupCleanupCommand = ''
        cd /home/cole/server-drive/home/cole/immich
        \${lib.getExe pkgs.docker} compose start
      '';
      environmentFile = config.age.secrets.restic.path;
      repository = "s3:s3.ca-east-006.backblazeb2.com/archserver-backups";
      paths = [
        "/home/cole/server-drive/home/cole/immich/postgres_dump"
        "/media/photos-immich/"
      ];
      timerConfig = {
        OnCalendar = "*-*-* 00,12:00:00";
        AccuracySec = "6hours";
        Persistent = true;
      };
    };
  };
}
