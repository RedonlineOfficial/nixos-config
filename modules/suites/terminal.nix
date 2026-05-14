{ self, inputs, ... }: {
  flake.nixosModules.suiteTerminal = { ... }: {
    imports = [
      self.nixosModules.zsh
    ];
  };

  flake.homeModules.suiteTerminal = { ... }: {
    imports = [
      self.homeModules.zsh
      self.homeModules.zoxide
      self.homeModules.lsd
      self.homeModules.nvf
    ];
  };
}
