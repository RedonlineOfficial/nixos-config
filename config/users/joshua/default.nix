{
  self,
  inputs,
  ...
}: {
  flake-file.inputs = {
    claude-code.url = "github:sadjow/claude-code-nix";
  };

  flake.nixosModules.userJoshua = {pkgs, ...}: {
    users.users.joshua = {
      isNormalUser = true;
      description = "Joshua Myers";
      extraGroups = ["networkmanager" "wheel"];
    };

    home-manager.users."joshua".imports = [self.homeModules.joshuaHome];
  };

  flake.homeConfigurations.joshua = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [
      {
        nixpkgs.overlays = [claude-code.overlays.default];
        home.packages = [pkgs.claude-code];
      }

      self.homeModules.joshuaHome
    ];
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    extraSpecialArgs = {inherit inputs self;};
  };
}
