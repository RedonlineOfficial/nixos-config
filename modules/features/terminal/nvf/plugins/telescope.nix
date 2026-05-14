{ self, inputs, ... }: {
  flake.homeModules.nvfPlugins-telescope = { ... }: {
    programs.nvf.settings.vim.telescope = {
      enable = true;
    };
  };
}
