{
  description = "My NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:NIXOS/nixpkgs/nixos-25.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixvim.url = "github:nix-community/nixvim";
    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs = {
        pyproject-nix.follows = "pyproject-nix";
        nixpkgs.follows = "nixpkgs";
      };
    };
    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs = {
        pyproject-nix.follows = "pyproject-nix";
        uv2nix.follows = "uv2nix";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-wsl,
      nixvim,
      uv2nix,
      pyproject-nix,
      pyproject-build-systems,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (nixpkgs) lib;
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
          projectPath = ./python-base;
          workspace = uv2nix.lib.workspace.loadWorkspace {
            workspaceRoot = projectPath;
          };
          overlay = workspace.mkPyprojectOverlay {
            sourcePreference = "wheel";
          };
          editableOverlay = workspace.mkEditablePyprojectOverlay {
            root = "$REPO_ROOT";
          };
          pythonSet =
            (pkgs.callPackage pyproject-nix.build.packages {
              python = pkgs.python3;
            }).overrideScope
              (
                lib.composeManyExtensions [
                  pyproject-build-systems.overlays.wheel
                  overlay
                ]
              );
          editablePythonSet = pythonSet.overrideScope editableOverlay;
          virtualenv = editablePythonSet.mkVirtualEnv "python-base-dev-env" workspace.deps.all;
        in
        pkgs.mkShell {
          packages = [
            virtualenv
            pkgs.uv
          ];
          env = {
            UV_NO_SYNC = "1";
            UV_PYTHON = editablePythonSet.python.interpreter;
            UV_PYTHON_DOWNLOADS = "never";
          };
          shellHook = ''
            unset PYTHONPATH
            export REPO_ROOT="${projectPath}" 

            echo "
            entering python environment [python-base]
            "
          '';
        };
    };
}
