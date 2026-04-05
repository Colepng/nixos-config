{
  config,
  ...
}:

{

  fileSystems."/mnt/Games" = {
    device = "/dev/disk/by-uuid/a8efed91-0f5a-46e7-973b-b5704daf4afe";
    fsType = "btrfs";
    options = [
      "users"
      "nofail"
      "x-gvfs-show"
      "exec"
    ];
  };

  networking.hostName = "lenovo";
}
