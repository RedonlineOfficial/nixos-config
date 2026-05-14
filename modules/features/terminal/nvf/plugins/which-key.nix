{ self, inputs, ... }: {
  flake.homeModules.nvfPlugins-whichkey = { ... }: {
    programs.nvf.settings.vim.binds.whichKey = {
      enable = true;
    };
  };
}
