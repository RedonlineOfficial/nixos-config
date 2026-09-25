{ inputs, ... }: {
  flake-file.inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.core-disko = { ... }: {
    imports = [ inputs.disko.nixosModules.disko ];
  };
}
