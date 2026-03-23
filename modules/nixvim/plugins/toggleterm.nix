{ config, pkgs, ... }:
{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      settings = {
        size = 10;
        direction = "horizontal";
        start_in_insert = true;
        close_on_exit = true;
        float_opts = {
          border = "rounded";
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>t";
        action = "<cmd>ToggleTerm direction=horizontal<CR>";
        options = {
          desc = "ToggleTerm (Horizontal)";
          silent = true;
        };
      }
    ];
  };
}
