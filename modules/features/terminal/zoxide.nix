{ self, inputs, ... }: {
  flake.homeModules.zoxide = { ... }: {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
