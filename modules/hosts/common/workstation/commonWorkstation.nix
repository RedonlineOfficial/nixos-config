{ self, inputs, ... }: {
  flake.nixosModules.commonWorkstation = { ... }: {
    imports = [ self.nixosModules.base ];
    networking.networkmanager.enable = true;
    nix = {
      gc = {
        automatic = true;
        dates = "Saturday *-*-* 00:00:00";
        persistent = true;
      };
      optimise = {
        automatic = true;
        dates = "Sunday *-*-* 00:00:00";
        persistent = true;
      };
    };
  };
}
