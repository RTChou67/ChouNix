{ config, pkgs, ... }:
{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = "tokyonight";
        globalstatus = true;
      };
    };
  };
}
