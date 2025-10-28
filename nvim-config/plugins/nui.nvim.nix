{ config, pkgs, ... }:
{
  # 这是 noice 和 neo-tree 的依赖
  programs.nixvim.plugins.nui.enable = true;
}
