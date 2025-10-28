{ config, pkgs, ... }:
{
  programs.nixvim.plugins.toggleterm = {
    enable = true;
    # 键位映射和 autocmds 都在 core.nix 中
    settings = {
      size = 20;
      direction = "float";
      start_in_insert = true;
      close_on_exit = true;
      float_opts = {
        border = "rounded";
      };
    };
  };
}
