{ self, inputs, ... }: {

  flake.nixosModules.hostNixos-devConfiguration = { ... }: {
    imports = [];

    networking.hostName = "nixos-dev";

    system.stateVersion = "25.11";
  };
  
}
