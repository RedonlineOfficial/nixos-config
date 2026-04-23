{ self, inputs, ... }: {
  flake.nixosModules.profilesCommon = { ... }: {
    imports = [
      self.nixosModules.git
      self.nixosModules.ssh
    ];
  };

  flake.homeModules.profilesCommon = { ... }: {
    imports = [
      self.homeModules.git
    ];
  };
}
