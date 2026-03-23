{ config, pkgs, ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      indent.enable = true;
      highlight.enable = true;
      textobjects = {
        enable = true;
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = "@class.inner";
            "ia" = "@parameter.inner";
            "aa" = "@parameter.outer";
          };
        };
      };
    };
    folding = false;
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  };
}
