{ self, inputs, ... }: {
  flake.homeModules.nvfPlugins-oil = { ... }: {
    programs.nvf.settings.vim.utility.oil-nvim = {
      enable = true;
      setupOpts.keymaps."<C-l>" = false;
      gitStatus.enable = true;
      setupOpts = {
        win_options = {
          signcolumn = "yes";
        };

        delete_to_trash = true;
        watch_for_changes = true;

        view_options = {
          show_hidden = true;
          is_hidden_file = # lua
          ''
            function(name, bufnr)
              local m = name:match("^%.")
              return m ~= nil
            end
          '';
          is_always_hidden = # lua
          ''
            function(name, bufnr)
              local m = name:match("^%.git")
              return m ~= nil
            end
          '';
        };
      };
    };

    programs.nvf.settings.vim = {
      maps.normal = {
        "<leader>fe" = { action = "<cmd>Oil<CR>"; desc = "Open Oil"; };
      };
    };
  };
}
