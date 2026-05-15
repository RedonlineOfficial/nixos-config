{ self, inputs, ... }: {
  flake.homeModules.CHANGEME = { ... }: {
    programs.btop = {
      enable = true;
    };
  };
}

