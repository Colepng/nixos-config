{ pkgs, ... }:
{
  systemd.services.task-sync = {
    description = "Taskwarrior sync";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "cole";
      ExecStart = "${pkgs.taskwarrior3}/bin/task sync";
    };
  };

  systemd.timers.task-sync = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
      Unit = "task-sync.service";
    };
  };
}
