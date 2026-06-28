{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (heroic.override {
      extraPkgs =
        pkgs': with pkgs'; [
          gamescope
          gamemode
        ];
    })
    protonup-qt
    prismlauncher
  ];
}
