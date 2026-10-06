{ inputs, pkgs, ... }:
{
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
      package = inputs.nixpkgs-master.legacyPackages.${pkgs.stdenv.hostPlatform.system}.jellyfin;
      group = "media";
    };

    seerr = {
      enable = true;
      openFirewall = true;
    };
  };
}
