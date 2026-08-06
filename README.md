# Helium-Browser-flake

Nix flake for [Helium](https://helium.computer/) browser on NixOS.

> A private, fast, and honest web browser based on Chromium.

## Usage

Add to your `flake.nix` inputs:
```nix
inputs = {
  helium.url = "github:amaraulakh956/Helium-Browser-flake";
};
```

Add `helium` to your outputs args:
```nix
outputs = { self, nixpkgs, helium, ... } @ inputs:
```

### Option 1 — home-manager

Add to your `home.nix` packages:
```nix
home.packages = [
  inputs.helium.packages.x86_64-linux.helium
];
```

Make sure `inputs` is available in home-manager via `extraSpecialArgs`:
```nix
home-manager.extraSpecialArgs = { inherit inputs; };
```

### Option 2 — NixOS system packages

Add to your `configuration.nix`:
```nix
environment.systemPackages = [
  inputs.helium.packages.x86_64-linux.helium
];
```

### Option 3 — nix run (no install)

```bash
nix run github:amaraulakh956/Helium-Browser-flake
```

## Auto-updates

This flake is automatically updated daily via GitHub Actions whenever a new Helium release is available.

## Platforms

- `x86_64-linux`
