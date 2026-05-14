{ self, inputs, ... }: {
  flake.nixosConfigurations.hm-pc-ws-01 = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit self inputs; };

    modules = [
      # Disk Config
      self.nixosModules.disko-efiSingleLuksExt4
      # Common System Config
      self.nixosModules.commonLaptop

      # Host config
      self.nixosModules.hm-pc-ws-01

      # User config
      self.nixosModules.joshua
    ];
  };

  flake.nixosModules.hm-pc-ws-01 = { config, ... }: {
    imports = [ ./_hardware-configuration.nix ];

    # disko config
    diskoOpts.device = "/dev/nvme0n1";

    # Networking
    networking.hostName = "hm-pc-ws-01";

    system.stateVersion = "25.11";
  };
}
