{ self, inputs, ... }: {
  flake.nixosConfigurations.hostNixos-dev = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      self.nixosModules.hostCommon
      self.nixosModules.hostNixos-devConfiguration
      self.nixosModules.userJoshua
    ];
  };
}
