# Nix os module that contains all configuartion rust toolings
{ pkgs, rust-overlay, ... }:

{
  nixpkgs.overlays = [ rust-overlay.overlays.default ];
  environment.systemPackages = with pkgs; [
    (rust-bin.selectLatestNightlyWith (
      toolchain:
      toolchain.default.override {
        extensions = [
          "miri"
          "rust-src"
          "llvm-tools-preview"
        ];
        targets = [ "x86_64-unknown-none" ];
      }
    ))
    gcc
  ];
}
