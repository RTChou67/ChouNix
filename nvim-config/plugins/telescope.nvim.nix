{ config, pkgs, ... }:
{
  programs.nixvim.plugins.telescope = {
    enable = true;
    # 键位映射在 core.nix 中
    
    # 自动启用 fzf-native 扩展
    extensions."fzf-native".enable = true;
  };
}
