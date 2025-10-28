{ config, pkgs, ... }:
{
  # 这是 nvim-cmp 的一个依赖 (用于 snippets)
  programs.nixvim.plugins.luasnip.enable = true;
}
