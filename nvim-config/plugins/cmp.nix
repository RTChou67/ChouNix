# /etc/nixos/nvim_config/plugins/cmp.nix
{ config, pkgs, ... }:

{
  # 唯一的顶层键是 "programs.nixvim"
  programs.nixvim = {

    # 1. 'plugins' 块现在在 'programs.nixvim' 内部
    plugins = {
      cmp = {
        enable = true;
        settings = {
          snippet.expand = "luasnip.lsp_expand";
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
        };

        # 'extraOptions' 是 'plugins.cmp' 的一个有效选项
          };

      # cmp 依赖项 (这些都在 'plugins' 块内部)
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-cmdline.enable = true;
      cmp_luasnip.enable = true;
    };

    # 2. 'extraConfigLua' 现在也在 'programs.nixvim' 内部
    extraConfigLua = ''
      local cmp = require('cmp')

      -- 这是你的搜索 '/' 和 '?' 配置
      cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- 这是你的命令 ':' 配置
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        }),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    '';

  }; # 结束 'programs.nixvim' 块
}
