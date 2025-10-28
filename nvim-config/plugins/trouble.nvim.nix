{ config, pkgs, ... }:
{
  # 键位映射在 core.nix 中
  programs.nixvim.plugins.trouble.enable = true;
}
