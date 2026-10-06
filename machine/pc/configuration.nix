{
  config,
  pkgs,
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

  networking.hostName = "pc";

  networking.firewall.allowedTCPPorts = [
    80
    443
    2283
  ];

  networking.nameservers = [ "localhost:53" ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  virtualisation.docker = {
    enable = true;
  };
}
