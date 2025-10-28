{
  description = "NixOS-WSL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixvim.url = "github:nix-community/nixvim";  };

  outputs = { self, nixpkgs, nixos-wsl, nixvim, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { };
      modules = [
        nixos-wsl.nixosModules.wsl
        nixvim.nixosModules.nixvim
        ./configuration.nix
      ];
    };
  };
}
