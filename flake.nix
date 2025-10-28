{
  description = "NixOS-WSL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    
    # --- ADD THIS INPUT ---
    nixvim.url = "github:nix-community/nixvim"; # <-- ADD THIS
  };

  outputs = { self, nixpkgs, nixos-wsl, nixvim /* <-- ADD THIS */, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { };
      modules = [
        # Import your existing configuration
        ./configuration.nix

        # --- ADD THESE MODULES ---
        nixos-wsl.nixosModules.wsl
        nixvim.nixosModules.nixvim # <-- ADD THIS
      ];
    };
  };
}
