{ config, pkgs, ... }:
{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        python = [ "black" ];
        lua = [ "stylua" ];
        cpp = [ "clang-format" ];
        sh = [ "shfmt" ];
        zsh = [ "shfmt" ];
        tex = [ "latexindent" ];
        nix = [ "nixfmt" ];
      };

      format_on_save = {
        timeout_ms = 500;
        lsp_fallback = true;
      };
    };
  };
}
