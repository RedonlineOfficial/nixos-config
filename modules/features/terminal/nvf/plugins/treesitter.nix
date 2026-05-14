{ self, inputs, ... }: {
  flake.homeModules.nvfPlugins-treesitter = { ... }: {
    programs.nvf.settings.vim.treesitter = {
      enable = true;
    };
  };
}
