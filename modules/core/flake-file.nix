{ inputs, ... }: {
  flake-file.inputs = {
    # --- Nixpkgs ------------------------------------------------------------------------
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # --- Dendritic ----------------------------------------------------------------------
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-file = {
      url = "github:denful/flake-file";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree = {
      url = "github:denful/import-tree";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- System Utilities ---------------------------------------------------------------
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake-file.outputs = /* nix */ ''
    inputs: inputs.flake-parts.lib.mkFlake
      { inherit inputs; } 
      (inputs.import-tree ./modules)
  '';
}
