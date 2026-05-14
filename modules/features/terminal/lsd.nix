{ self, inputs, ... }: {
  flake.homeModules.lsd = { ... }: {
    programs.lsd = {
      enable = true;
      enableZshIntegration = false; # zshIntegration overwrites some aliases
    };
  };
}
