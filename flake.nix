{
  description = "My NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:NIXOS/nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixvim.url = "github:nix-community/nixvim";
    uv2nix.url = "github:pyproject-nix/uv2nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      nixvim,
      uv2nix,
      ...
    }:
    let

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {

        };
        modules = [
          nixos-wsl.nixosModules.wsl
          nixvim.nixosModules.nixvim
          ./configuration.nix
        ];
      };
      devShells.${system}.python-base =
        let
          python-base-workspace = uv2nix.lib.workspace.loadWorkspace {
            workspaceRoot = ./python-base;
          };
          python-base-env = pkgs.python3.withPackages (
            uv2nix.lib.mkPythonPackages {
              pkgs = pkgs;
              workspace = python-base-workspace;
            }
          );
        in
        pkgs.mkShell {
          name = "python-base-shell";
          packages = [
            python-base-env
          ];
          shellHook = ''
                        echo "
            						entering python-base environment
                        "
          '';
        };
    };
}
