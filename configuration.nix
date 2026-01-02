{ lib, pkgs, ... }:

{
  imports = [ ./nvim-config ];

  wsl.enable = true;
  wsl.defaultUser = "rtchou";

  # 系统层只保留最基础的包
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  nix.settings = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
