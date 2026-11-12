{
  ...
}:

{
  programs = {
    fish.enable = true;

    starship = {
      enable = true;
      enableFishIntegration = true;
      presets = [ "gruvbox-rainbow" ];
    };

    noisetorch.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # spicetify = {
    #   enable = true;
    #   enabledExtensions =
    #     with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
    #       allOfArtist
    #       wikify
    #       skipStats
    #       fullScreen
    #     ];
    # };

    nh = {
      enable = true;
    };

    nix-ld.enable = true;

    coolercontrol = {
      enable = true;
    };
  };
}
