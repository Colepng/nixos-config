# Nix os module that contains all configuartion rust toolings
{
  pkgs,
  rust-overlay,
  ...
}:

{
  nixpkgs.overlays = [
    rust-overlay.overlays.default
  ];
  environment.systemPackages = with pkgs; [
    (rust-bin.selectLatestNightlyWith (
      toolchain:
      toolchain.default.override {
        extensions = [
          "miri"
          "rust-src"
          "rustc-dev"
          "llvm-tools-preview"
          "rust-analyzer"
        ];
        targets = [
          "x86_64-unknown-none"
          "x86_64-unknown-linux-gnu"
        ];
      }
    ))
    gcc
  ];
}
