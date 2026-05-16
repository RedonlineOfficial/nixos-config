{ self, inputs, ... }: {
  flake.homeModules.btop = { ... }: {
    programs.btop = {
      enable = true;
    };
  };
}

