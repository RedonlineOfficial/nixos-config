{ self, inputs, ... }: {
  flake.homeModules.ripgrep = { ... }: {
    programs.ripgrep = {
      enable = true;
      argumnets = [
        "--smart-case"
        "--pretty"
      ];
    };
  };
}
