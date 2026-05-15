{ self, inputs, ... }: {
  flake.homeModules.fd = { ... }: {
    programs.fd = {
      enable = true;
      hidden = true;
    };
  };
}
