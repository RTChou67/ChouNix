{ config, pkgs, ... }:
{
  # 这是 nvim-cmp 的一个依赖 (用于图标)
  programs.nixvim.plugins.lspkind.enable = true;
}
