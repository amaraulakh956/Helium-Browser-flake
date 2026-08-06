{
  description = "Helium browser for NixOS";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.helium =
      nixpkgs.legacyPackages.x86_64-linux.callPackage ./pkgs/helium.nix {};
    packages.x86_64-linux.default =
      self.packages.x86_64-linux.helium;
  };
}
