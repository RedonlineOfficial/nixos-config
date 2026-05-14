{ self, inputs, ... }: {

  flake-file.inputs = {
    auto-cpufreq.url = "github:AdnanHodzic/auto-cpufreq";
    auto-cpufreq.inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.nixosModules.commonLaptop = { ... }: {
    imports = [
      # Inputs
      inputs.auto-cpufreq.nixosModules.default

      # Hardware
      inputs.nixos-hardware.nixosModules.common-pc-laptop

      # Workstation Module
      self.nixosModules.commonWorkstation
    ];

    services.thermald.enable = true;

    programs.auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
}
