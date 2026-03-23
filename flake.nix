{
  description = "My NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:NIXOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixvim.url = "github:nix-community/nixvim";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Python 相关 inputs
    pyproject-nix.url = "github:pyproject-nix/pyproject.nix";
    uv2nix.url = "github:pyproject-nix/uv2nix";
    pyproject-build-systems.url = "github:pyproject-nix/build-system-pkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      nixvim,
      home-manager,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      pythonBaseRoot = ./python-base;
      pythonBaseWorkspace = inputs.uv2nix.lib.workspace.loadWorkspace {
        workspaceRoot = pythonBaseRoot;
      };
      pythonBaseOverlay = pythonBaseWorkspace.mkPyprojectOverlay {
        sourcePreference = "wheel";
      };
      pythonBaseSet =
        (pkgs.callPackage inputs.pyproject-nix.build.packages {
          python = pkgs.python3;
        }).overrideScope (
          lib.composeManyExtensions [
            inputs.pyproject-build-systems.overlays.wheel
            pythonBaseOverlay
          ]
        );
      pythonBaseVirtualenv =
        pythonBaseSet.mkVirtualEnv "python-base-dev-env" pythonBaseWorkspace.deps.all;
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;
      packages.${system}.python-base = pythonBaseVirtualenv;

      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nixfmt-rfc-style
            statix
          ];
        };

        python-base = pkgs.mkShell {
          packages = [
            pythonBaseVirtualenv
            pkgs.uv
          ];
          env = {
            UV_NO_SYNC = "1";
            UV_PYTHON = pythonBaseSet.python.interpreter;
            UV_PYTHON_DOWNLOADS = "never";
          };
          shellHook = ''
            export REPO_ROOT=${toString pythonBaseRoot}
            export PYTHONPATH="$REPO_ROOT:${PYTHONPATH:-}"
          '';
        };
      };

      checks.${system} = {
        nixos = self.nixosConfigurations.nixos.config.system.build.toplevel;
        python-base = self.packages.${system}.python-base;
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          pythonBasePackage = pythonBaseVirtualenv;
        };
        modules = [
          nixos-wsl.nixosModules.wsl
          nixvim.nixosModules.nixvim
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.rtchou = import ./home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              pythonBasePackage = pythonBaseVirtualenv;
            };
          }
        ];
      };
    };
}
