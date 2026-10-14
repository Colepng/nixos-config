{ inputs, pkgs, ... }:
{
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
      group = "media";
    };

    seerr = {
      enable = true;
      openFirewall = true;
    };
  };
}
