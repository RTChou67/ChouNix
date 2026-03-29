{ ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };

  imports = [
    ./core.nix
    ./plugins/aerial.nix
    ./plugins/bufferline.nix
    ./plugins/cmp.nix
    ./plugins/colorizer.nix
    ./plugins/comment.nix
    ./plugins/conform-nvim.nix
    ./plugins/gitsigns.nix
    ./plugins/indent-blankline.nix
    ./plugins/lazygit.nix
    ./plugins/lint.nix
    ./plugins/lsp.nix
    ./plugins/lspkind.nix
    ./plugins/lualine.nix
    ./plugins/luasnip.nix
    ./plugins/neo-tree.nix
    ./plugins/noice.nix
    ./plugins/notify.nix
    ./plugins/nui.nix
    ./plugins/nvim-autopairs.nix
    ./plugins/telescope.nvim.nix
    ./plugins/todo-comments.nix
    ./plugins/toggleterm.nix
    ./plugins/tokyonight.nix
    ./plugins/treesitter.nix
    ./plugins/trouble.nix
    ./plugins/vim-surround.nix
    ./plugins/web-devicons.nix
    ./plugins/which-key.nix
  ];
}
