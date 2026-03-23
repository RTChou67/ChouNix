{ config, pkgs, ... }:
{
  programs.nixvim = {

    plugins.aerial = {
      enable = true;
      settings = {
        layout = {
          default_direction = "right";
          width = 30;
          backends = {
            html = [
              "lsp"
              "treesitter"
            ];
          };
        };
      };

    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>o";
        action = ":AerialToggle<CR>";
        options = {
          desc = "Aerial: Toggle code outline";
          silent = true;
        };
      }
    ];
  };
}
