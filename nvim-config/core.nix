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
    keymaps=[
    {
        mode = [ "n" "i" ];
        key = "<C-s>";
        action = "<cmd>w<cr>";
        options = {
          desc = "Save file";
        };
      }
      {
        mode = "n";
        key = "<esc><esc>";
        action = "<cmd>wqa!<cr>";
        options = {
          desc = "Save and quit all";
        };
      }
    ];
  };
}
