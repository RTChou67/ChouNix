# ChouNix

Personal NixOS WSL configuration managed as a single flake.

## Layout

- `flake.nix`: root flake, shared inputs, NixOS configuration, dev shells, checks
- `configuration.nix`: WSL-specific NixOS host module
- `home.nix`: Home Manager configuration and shell customizations
- `nvim-config`: Nixvim module and plugin split
- `python-base`: uv2nix-based Python development shell

## Python Base

The `python-base` environment is exposed in two ways:

- as the default user-level base Python environment through Home Manager
- as a flake dev shell for explicit development workflows

When you enter a project directory managed by `direnv`, that project environment should override the base Python by `PATH` precedence.

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

Use the project-local Python shell with direnv:

```bash
cd python-base
direnv allow
```

Format Nix files:

```bash
nix fmt
```
