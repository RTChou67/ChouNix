{ config, pkgs, ... }:
{
  programs.nixvim = {
    # 将其设为默认主题
    colorscheme = "tokyonight";
    
    # 配置主题插件
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "storm";
        transparent = false;
        terminal_colors = true;
        styles = {
          comments.italic = true;
          keywords.italic = true;
          functions = {};
          variables = {};
        };
      };
    };
  };
}
