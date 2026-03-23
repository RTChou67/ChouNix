{ pkgs, lib, ... }:

{

  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;

      settings = {
        close_if_last_window = false;
        popup_border_style = "rounded";
        enable_git_status = true;
        enable_diagnostics = true;
        close_on_open = false;
        open_files_do_not_replace_types = [
          "terminal"
          "trouble"
          "qf"
        ];

        default_component_configs = {
          container = {
            enable_character_fade = true;
          };
          indent = {
            indent_size = 2;
            padding = 1;
            with_markers = true;
            indent_marker = "│";
            last_indent_marker = "└";
            highlight = "NeoTreeIndentMarker";
          };
          icon = {
            folder_closed = "";
            folder_open = "";
            folder_empty = "";
            default = "*";
            highlight = "NeoTreeFileIcon";
          };
          modified = {
            symbol = "●";
            highlight = "NeoTreeModified";
          };
          name = {
            trailing_slash = false;
            use_git_status_colors = true;
            highlight = "NeoTreeFileName";
          };
          git_status = {
            symbols = {
              # “最终”状态
              added = ""; # Octicon: check (已添加)
              staged = ""; # Octicon: check (已暂存)
              deleted = ""; # Octicon: trash (已删除)
              conflict = ""; # Octicon: conflict (冲突)
              renamed = ""; # Octicon: arrow-right (重命名)
              ignored = ""; # Octicon: eye-closed (已忽略)

              # “工作区”状态 (优化后)
              modified = ""; # Octicon: primitive-dot (已修改)
              untracked = ""; # Octicon: question (未跟踪的新文件)
              unstaged = ""; # Octicon: dash (未暂存的修改)
            };
          };
        };
        window = {
          position = "left";
          width = 30;
          mapping_options = {
            noremap = true;
            nowait = true;
          };

          mappings = {

            "<2-LeftMouse>" = "open";
            "<cr>" = "open";
            "o" = "open";
            "S" = "open_split";
            "s" = "open_vsplit";
            "t" = "open_tabnew";
            "w" = "open_with_window_picker";
            "C" = "close_node";
            "z" = "close_all_nodes";
            "d" = "delete";
            "r" = "rename";
            "y" = "copy_to_clipboard";
            "x" = "cut_to_clipboard";
            "p" = "paste_from_clipboard";
            "c" = "copy";
            "m" = "move";
            "q" = "close_window";
            "R" = "refresh";
            "?" = "show_help";
            "<" = "prev_source";
            ">" = "next_source";
            "H" = "toggle_hidden";

          };
        };
        nesting_rules = { };
        filesystem = {
          filtered_items = {
            visible = false;
            hide_dotfiles = false;
            hide_gitignored = true;
            hide_hidden = true;
            hide_by_name = [ ];
            hide_by_pattern = [ ];
            always_show = [ ];
            never_show = [
              ".DS_Store"
              "thumbs.db"
            ];
          };
          follow_current_file = {
            enabled = true;
            leave_dirs_open = false;
          };
          group_empty_dirs = false;
          hijack_netrw_behavior = "open_current";
          use_libuv_file_watcher = false;
          window = {
            mappings = {
              "/" = "fuzzy_finder";
              "f" = "filter_on_submit";
              "<c-x>" = "clear_filter";
              "[g" = "prev_git_modified";
              "]g" = "next_git_modified";
            };
          };
        };
        buffers = {
          follow_current_file = {
            enabled = true;
            leave_dirs_open = false;
          };
          group_empty_dirs = true;
          show_unloaded = true;
          window = {
            mappings = {
              "bd" = "buffer_delete";
              "<bs>" = "navigate_up";
              "." = "set_root";
            };
          };
        };
        git_status = {
          window = {
            position = "float";
            mappings = {
              "A" = "git_add_all";
              "gu" = "git_unstage_file";
              "ga" = "git_add_file";
              "gr" = "git_revert_file";
              "gc" = "git_commit";
              "gp" = "git_push";
              "gg" = "git_commit_and_push";
            };
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = ":Neotree toggle<CR>";
        options.desc = "Neo-tree: Toggle file explorer";
      }
    ];
  };
}
