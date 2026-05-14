{ self, inputs, ... }: {
  flake-file.inputs = {
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.homeModules.nvf = { ... }: {
    imports = [
      inputs.nvf.homeManagerModules.default

      self.homeModules.nvfOptions
      self.homeModules.nvfTheme
      self.homeModules.nvfKeybinds
      self.homeModules.nvfLsp
      self.homeModules.nvfPlugins
    ];

    programs.nvf.enable = true;
  };
}
