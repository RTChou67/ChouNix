# /etc/nixos/nvim_config/core.nix
{ config, pkgs, ... }:

{
  programs.nixvim = {
    globals.mapleader = " ";
    globals.maplocalleader = " ";
    opts = {
      number = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      autoindent = true;
      timeoutlen = 500;
      updatetime = 300;
      termguicolors = true;
    };

    diagnostic.settings = {
      virtual_text = true;
      signs = true;
      underline = true;
      update_in_insert = true;
      severity_sort = true;
    };
  };
}
