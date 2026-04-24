{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.nixos-dev = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      self.nixosModules.hostCommon
      self.nixosModules.nixos-devConfiguration
      self.nixosModules.nixos-devHardware
      self.nixosModules.userJoshua
    ];
  };
}
