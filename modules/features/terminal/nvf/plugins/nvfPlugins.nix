{ self, inputs, ... }: {
  flake.homeModules.nvfPlugins = { ... }: {
    imports = [
      self.homeModules.nvfPlugins-treesitter
      self.homeModules.nvfPlugins-telescope
      self.homeModules.nvfPlugins-whichkey
      self.homeModules.nvfPlugins-blinkcmp
      self.homeModules.nvfPlugins-oil
    ];
  };
}
