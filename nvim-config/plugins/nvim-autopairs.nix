# /etc/nixos/nvim-config/plugins/nvim-autopairs.nix
{ config, pkgs, ... }:

{

  programs.nixvim.plugins.nvim-autopairs = {
    enable = true;
    settings = {

      disable_for_filetype = [
        "TelescopePrompt"
        "vim"
      ];
      check_ts = true;
      ts_config = {
        lua = [
          "string"
          "source"
        ];
        javascript = [
          "string"
          "template_string"
        ];
        java = false;
      };
    };
  };
}
