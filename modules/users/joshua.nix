{ self, inputs, ... }: {
  flake.nixosModules.joshua = { pkgs, ... }: {
    imports = [
      self.nixosModules.suiteTerminal
    ];
    users.users.joshua = {
      description = "Joshua Myers";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.zsh;
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
    imports = [
      self.homeModules.suiteTerminal
    ];
    home = {
      username = "joshua";
      homeDirectory = "/home/joshua";
      stateVersion = "25.11";
    };
  };
}
