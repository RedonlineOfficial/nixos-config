{ self, inputs, ... }: {
  flake.nixosModules.zsh = { ... }: {
    programs.zsh.enable = true;
  };

  flake.homeModules.zsh = { ... }: {
    imports = [
      self.homeModules.zshOptions
      self.homeModules.zshAliases
      self.homeModules.zshPrompt
      self.homeModules.zshFunctions
    ];
    programs.zsh.enable = true;
  };
}
