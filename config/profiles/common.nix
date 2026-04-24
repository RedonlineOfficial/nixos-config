{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.profilesCommon = {...}: {
    imports = [
      self.nixosModules.git
      self.nixosModules.ssh
      self.nixosModules.neovim
      self.nixosModules.zsh
    ];
  };

  flake.homeModules.profilesCommon = {...}: {
    imports = [
      self.homeModules.git
      self.homeModules.neovim
      self.homeModules.zsh
    ];
  };
}
