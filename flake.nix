{ description = "Redonline's nix configuration";

  outputs = { self, nixpkgs, ... } @inputs: let 
    inherit (self) outputs;
    inherit (nixpkgs) lib;

    forAllSystems = lib.genAttrs [
      "x86_64-linux"
    ];

    mkSystem = host: {
      ${host} = lib.nixosSystem {
      	specialArgs = {
      	  inherit inputs outputs;
	  lib = nixpkgs.lib.extend (final: prev: {
	    custom = import ./lib {inherit (nixpkgs) lib; };
	  });
	};

	modules = [ ./host/nixos/${host} ];
      };
    };

    mkHostConfigs = hosts: lib.foldl (acc: set: acc // set) { } (lib.map (host: mkSystem host) hosts);

    readHostDirs = folder: lib.attrNames (builtins.readDir ./hosts/${folder});
  in {
    nixosConfigurations = mkHostConfigs (readHostDirs "nixos");

    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    overlays = import ./overlays { inherit inputs; };

    commonModules = import ./modules/common;
    nixosModules = import ./modules/common;
    homeModules = import ./modules/common;

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-stable = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable = "github:nixos/nixpkgs/nixos-unstable";

    hardware = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
