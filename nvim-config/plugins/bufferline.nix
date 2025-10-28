{ config, pkgs, ... }:
{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        mode = "buffers";
        separator_style = "slant";
        diagnostics = "nvim_lsp";
        show_close_icon = false;
        always_show_bufferline = true;
        offsets = [
          {
            filetype = "neo-tree";
            text = "File Explorer";
            text_align = "center";
            separator = true;
          }
        ];
      };
    };
  };
}
