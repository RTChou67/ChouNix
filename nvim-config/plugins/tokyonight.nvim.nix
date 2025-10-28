{ config, pkgs, ... }:
{
  programs.nixvim = {

    colorscheme = "tokyonight";

    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "storm";
        transparent = false;
        terminal_colors = true;
        styles = {
          comments.italic = true;
          keywords.italic = true;
          functions = { };
          variables = { };
        };
      };
    };
  };
}
