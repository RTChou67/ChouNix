{ config, pkgs, ... }:
{
  programs.nixvim = {

    plugins.lsp.enable = true;

    plugins.lsp.servers = {
      lua_ls.enable = true;
      pyright.enable = true;
      texlab.enable = true;
      #julia_ls.enable = true;
      nixd.enable = true;
      html.enable = true;
    };
  };
}
