# ChouNix

Personal NixOS WSL configuration managed as a single flake.

## Layout

- `flake.nix`: root flake, shared inputs, NixOS configuration, dev shells, checks
- `hosts/wsl`: WSL-specific NixOS host module
- `home/rtchou`: Home Manager configuration and shell customizations
- `modules/nixvim`: Nixvim module and plugin split
- `devshells/python-base`: uv2nix-based Python development shell

## Common Commands

Build the system:

```bash
nixos-rebuild build --flake .#nixos
```

Switch the system:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

Check the flake:

```bash
nix flake check --show-trace
```

Enter the Python dev shell:

```bash
nix develop .#python-base
```

Use the Python shell with direnv:

```bash
cd devshells/python-base
direnv allow
```

Format Nix files:

```bash
nix fmt
```
