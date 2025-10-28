{ config, pkgs, ... }:
{
  # 这是 telescope 的一个扩展
  # 我们在 telescope.nvim.nix 中通过 extensions."fzf-native".enable = true;
  # 来启用它，nixvim 会自动处理安装。
  # 这个文件只是为了满足“一个插件一个文件”的规范。
  programs.nixvim.plugins.telescope.extensions."fzf-native".enable = true;
}
