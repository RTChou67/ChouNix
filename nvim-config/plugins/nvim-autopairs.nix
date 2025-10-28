# /etc/nixos/nvim-config/plugins/nvim-autopairs.nix
{ config, pkgs, ... }:

{
  # 修正：使用正确的模块名称 "nvim-autopairs"
  programs.nixvim.plugins.nvim-autopairs = {
    enable = true;
    
    # 修正：所有 setup() 选项都必须包裹在 'settings' 块中
    settings = {
      # 在 settings 块中，我们使用 Lua 原始的 snake_case 命名
      disable_for_filetype = [ "TelescopePrompt" "vim" ];
      check_ts = true;
      ts_config = {
        lua = [ "string" "source" ];
        javascript = [ "string" "template_string" ];
        java = false;
      };
    };
    
    # 注意：所有复杂的 Lua 逻辑 (cmp 集成, rules)
    # 都在 core.nix 的 extraConfigLua 中，这是正确的。
  };
}
