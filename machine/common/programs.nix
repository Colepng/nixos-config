{
  pkgs,
  inputs,
  ...
}:

{
  programs = {
    fish.enable = true;

    noisetorch.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    spicetify = {
      enable = true;
      enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system}.extensions; [
        allOfArtist
        wikify
        skipStats
        fullScreen
      ];
    };

    nh = {
      enable = true;
    };
  };
}
