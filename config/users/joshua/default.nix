{ self, inputs, ... }: {
  flake.nixosModules.userJoshua = { ... }: {
    users.users.joshua = {
      isNormalUser = true;
      description = "Joshua Myers";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    home-manager.users."joshua".imports = [ self.homeModules.userJoshuaHome ];
  };

  flake.homeConfigurations.userJoshua = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [ 
      self.homeModules.userJoshuaHome 
    ];
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    extraSpecialArgs = { inherit inputs self; };

  };
}

