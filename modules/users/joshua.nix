{ self, inputs, ... }: {
  flake.nixosModules.joshua = { pkgs, ... }: {
    imports = [];
    users.users.joshua = {
      description = "Joshua Myers";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      packages = [ inputs.home-manager.packages.x86_64-linux.home-manager ];
    };
    home-manager.users.joshua.imports = [ self.homeModules.joshua ];
  };

  flake.homeConfigurations.joshua = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [ self.homeModules.joshua ];
    extraSpecialArgs = { inherit inputs self; };
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  };

  flake.homeModules.joshua = { pkgs, ... }: {
    imports = [];
    home = {
      username = "joshua";
      homeDirectory = "/home/joshua";
      stateVersion = "25.11";
    };
  };
}
