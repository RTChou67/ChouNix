{ config, pkgs, ... }:
{
  programs.nixvim.plugins.toggleterm = {
    enable = true;

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
