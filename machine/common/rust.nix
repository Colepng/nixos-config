# Nix os module that contains all configuartion rust toolings
{
  pkgs,
  rust-overlay,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [
    rust-overlay.overlays.default

    (final: prev: {
      neovim-unwrapped = inputs.nixpkgs-25.legacyPackages.${prev.system}.neovim-unwrapped;
    })

  ];
  environment.systemPackages = with pkgs; [
    (rust-bin.selectLatestNightlyWith (
      toolchain:
      toolchain.default.override {
        extensions = [
          "miri"
          "rust-src"
          "llvm-tools-preview"
          "rust-analyzer"
        ];
        targets = [ "x86_64-unknown-none" ];
      }
    ))
    gcc
  ];
}
