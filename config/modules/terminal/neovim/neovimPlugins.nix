{
  self,
  inputs,
  ...
}: {
  flake.homeModules.neovimPlugins = {...}: {
    programs.nvf.settings.vim = {
      # ── Treesitter ──────────────────────────────────────────────────────
      treesitter.enable = true;

      # ── Telescope ──────────────────────────────────────────────────────
      telescope.enable = true;

      # ── Which-key ──────────────────────────────────────────────────────
      binds.whichKey.enable = true;

      luaConfigRC.whichkey = ''
        require("which-key").add({
          { "<leader>s", group = "[S]earch", icon = { icon = "", color = "green" } },
        })
      '';

      # ── Blink-cmp ──────────────────────────────────────────────────────
      autocomplete.blink-cmp = {
        enable = true;
        setupOpts = {
          completion.documentation.auto_show = true;
          keymap = {
            "<C-p>" = ["select_prev" "fallback_to_mappings"];
            "<C-n>" = ["select_next" "fallback_to_mappings"];
            "<C-y>" = ["select_and_accept" "fallback"];
            "<C-e>" = ["cancel" "fallback"];
            "<C-space>" = ["show" "show_documentation" "hide_documentation"];
            "<Tab>" = ["snippet_forward" "fallback"];
            "<S-Tab>" = ["snippet_backward" "fallback"];
            "<C-b>" = ["scroll_documentation_up" "fallback"];
            "<C-f>" = ["scroll_documentation_down" "fallback"];
            "<C-k>" = ["show_signature" "hide_signature" "fallback"];
          };
          fuzzy.implementation = "lua";
        };
      };

      maps.normal = {
        # Telescope
        "<leader>sp" = {
          action = ":lua require('telescope.builtin').builtin()<CR>";
          silent = true;
          desc = "[S]earch Builtin [P]ickers";
        };
        "<leader>sb" = {
          action = ":lua require('telescope.builtin').buffers()<CR>";
          silent = true;
          desc = "[S]earch [B]uffers";
        };
        "<leader>sf" = {
          action = ":lua require('telescope.builtin').find_files()<CR>";
          silent = true;
          desc = "[S]earch [F]iles";
        };
        "<leader>sw" = {
          action = ":lua require('telescope.builtin').grep_string()<CR>";
          silent = true;
          desc = "[S]earch Current [W]ord";
        };
        "<leader>sg" = {
          action = ":lua require('telescope.builtin').live_grep()<CR>";
          silent = true;
          desc = "[S]earch by [G]rep";
        };
        "<leader>sr" = {
          action = ":lua require('telescope.builtin').resume()<CR>";
          silent = true;
          desc = "[S]earch [R]esume";
        };
        "<leader>sh" = {
          action = ":lua require('telescope.builtin').help_tags()<CR>";
          silent = true;
          desc = "[S]earch [H]elp";
        };
        "<leader>sm" = {
          action = ":lua require('telescope.builtin').man_pages()<CR>";
          silent = true;
          desc = "[S]earch [M]anuals";
        };
      };

      # ── Oil ──────────────────────────────────────────────────────
      utility.oil-nvim = {
        enable = true;
        setupOpts = {
          default_file_explorer = true;
          skip_confirm_for_simple_edits = true;
          watch_for_changes = true;
          constrain_cursor = "editable";
          cleanup_delay_ms = 2000;
          prompt_save_on_select_new_entry = true;
          buf_options = {
            buflisted = false;
            bufhidden = "hide";
          };
          win_options = {
            wrap = false;
            signcolumn = "no";
            cursorcolumn = false;
            foldcolumn = "0";
            spell = false;
            list = false;
            conceallevel = 3;
            concealcursor = "nvic";
          };
          lsp_file_methods = {
            enabled = true;
            timeout_ms = 1000;
            autosave_changes = false;
          };
          view_options = {
            show_hidden = true;
            natural_order = "fast";
            case_insensitive = false;
            sort = [
              ["type" "asc"]
              ["name" "asc"]
            ];
          };
          # Disable <C-l> in oil to preserve split navigation
          keymaps."<C-l>" = false;
        };
      };
      maps.normal = {
        "<leader>fe" = {
          action = ":lua ToggleOil()<CR>";
          silent = true;
          desc = "Toggle Oil";
        };
      };

      luaConfigRC.keymaps = ''
        function ToggleOil()
          local oil_buf = nil
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
            if ft == "oil" then
              oil_buf = buf
              break
            end
          end
          if oil_buf and vim.api.nvim_buf_is_valid(oil_buf) then
            vim.api.nvim_buf_delete(oil_buf, { force = true })
          else
            vim.cmd("Oil")
          end
        end
      '';
    };
  };
}
