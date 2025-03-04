{ description = "Redonline's Nixos Configuration";

  # --- Outputs --- #
  outputs = { self, nixpkgs, ... } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;

    # --- Architecture --- #
    # We create a list of the most popular system architectures. In this case, ARM - aarch64-linux and x86 - x86_64-linux.
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];

    # We take the list created above and use it as the list for the genAttrs function.  This will map each item in the list 
    # to a given function.  We use this down below.
    forAllSystems = lib.genAttrs systems;

    # --- nixosConfiguration Functions --- #

    # Takes an input (a hostname) and builds a Nix Configuration from it. 
    mkHost = host: {
      ${host} = lib.nixosSystem {
          specialArgs = { 
	    inherit inputs outputs;
	    # This attribute maps our own ./lib to lib.custom so we can easily call our functions in other modules;
	    # this method makes it available to home-manager as well.
            lib = nixpkgs.lib.extend (final: prev: { 
		custom = import ./lib { inherit (nixpkgs) lib; }; 
	    });
          };

	  # Finally we import our host configuration. The host configuration servers as the entry point to the rest of the system configuration.
          modules = [ ./hosts/nixos/${host} ];
        };
    };

    # This took me a while to figure out what this function did.  The top level explaination is that it maps an attribute name (hosts) to the output of mkHost. 
    # For more details, https://ryantm.github.io/nixpkgs/functions/library/lists/#function-library-lib.lists.foldl
    mkHostConfigs = hosts:  lib.foldl (acc: set: acc // set) { } (lib.map (host: mkHost host ) hosts);

    # Run through a directory and create a list from the attribute names of each subdirectory. 
    readHostDirs = folder: lib.attrNames (builtins.readDir ./hosts/${folder});


  in {
    # --- Nixos Configurations --- #
    # We use the three functions above in creating out nixosConfigurations.  First we read through the hosts/nixos directory and pull
    # a list of subdirectory names that we will use as an input.  We take that list and pipe it to mkHostConfigs.  This runs it through mkHost, 
    # building a host for each hostname found, and creating an attribute set of a hostname as the attribute name and the mkHost output as the attribute value. 
    # This makes it equivalent to nixosConfigurations { <hostname> = lib.nixosSystem {...} }. This gives us a huge benefit of not having to update
    # this flake everytime we add a host.
    # Credit: EmergentMind (https://github.com/EmergentMind/nix-config/blob/dev/flake.nix)
    nixosConfigurations = mkHostConfigs (readHostDirs "nixos");

    # --- Overlays --- #
    # Overlays are custom patches or changes we want to make to a package without having to edit the source code. 
    overlays = import ./overlays {inherit inputs;};

    # --- Custom Packages --- #
    # We take all our custom packages and map them to a system architecture that we specified in the list above
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # --- Formatter --- #
    # I'm new to using formatters and this was already here in Mistero's template, so I will leave it to play with it
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };

  # --- Inputs --- #
  inputs = {
    # --- Nixos Official Repositories --- #
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-stable = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # --- External System Utilities --- #
    # Home-manager: Declarative user configuration and dotfile management
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disko: Declarative disk partitioning and formatting utility
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

}
