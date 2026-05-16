{ self, inputs, ... }: {
  flake.homeModules.ripgrep = { ... }: {
    programs.ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
        "--pretty"
      ];
    };
  };
}
