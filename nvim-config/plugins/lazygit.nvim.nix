{ config, pkgs, ... }:

{
  # 唯一的顶层键是 "programs.nixvim"
  programs.nixvim = {

    # 1. 'plugins' 块现在在 'programs.nixvim' 内部
    plugins.lazygit = {
      enable = true;
    };

      extraConfigLua = ''
    require("telescope").load_extension("lazygit")
  '';

    # 3. 'keymaps' 块现在也在 'programs.nixvim' 内部
    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options = {
          desc = "LazyGit (root dir)";
        };
      }
    ];

  }; # 结束 'programs.nixvim' 块
}
