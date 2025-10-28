{ config, pkgs, ... }:
{

  programs.nixvim.plugins.telescope.extensions."fzf-native".enable = true;
}
