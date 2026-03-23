# TODO

## High Priority

- Verify the current flake end-to-end on NixOS:
  - `nix flake check --show-trace`
  - `nixos-rebuild build --flake .#nixos --show-trace`
  - `nix develop .#python-base`
- Review duplicate packages between `configuration.nix` and `home.nix`, then keep a single owner for each tool where practical.
- Revisit `activate-pybase` in `home.nix`:
  - confirm `nix print-dev-env .#python-base` behaves correctly in login shells
  - make activation/deactivation more robust if prompt or shell vars drift

## Medium Priority

- Decide whether `nvim-config` should remain imported from `configuration.nix` or move fully under Home Manager ownership.
- Review `home.packages` and remove low-value or unused packages.
- Keep the multi-shell setup intentional:
  - `zsh`
  - `fish`
  - `nushell`
  - only clean up shell integration bugs, not the shell set itself
- Validate the custom `rtchou` zsh theme behavior after the recent path changes.

## Low Priority

- Expand `README.md` with a short explanation of:
  - update workflow
  - rollback workflow
  - how `python-base` is expected to be used
- Consider adding more flake checks if they prove useful in practice.
- Review comments and old wording in config files for consistency.
