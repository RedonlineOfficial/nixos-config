{ self, inputs, ... }: {
  flake.homeModules.nvfPlugins-blinkcmp = { ... }: {
    programs.nvf.settings.vim.autocomplete.blink-cmp = {
      enable = true;
    };
  };
}
