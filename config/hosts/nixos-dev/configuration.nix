{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nixos-devConfiguration = {...}: {
    imports = [];

    networking.hostName = "nixos-dev";

    system.stateVersion = "25.11";
  };
}
