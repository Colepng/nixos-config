{ pkgs, config, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/irblack.yaml";
    polarity = "dark";
    cursor = {
      name = "Quintom_Ink";
      package = pkgs.quintom-cursor-theme;
      size = 24;
    };
    fonts = {
      sizes = {
        applications = 12;
        popups = 16;
      };
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.nerd-fonts.meslo-lg;
        name = "MesloLGS Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
