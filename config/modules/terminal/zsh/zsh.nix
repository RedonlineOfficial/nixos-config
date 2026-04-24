{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.zsh = {
    pkgs,
    config,
    lib,
    ...
  }: {
    options.modules.zsh.user = lib.mkOption {
      type = lib.types.str;
      default = "joshua";
      example = "johndoe";
      description = "Sets the user who will use zsh";
    };

    config = {
      environment.systemPackages = [pkgs.zsh];
      users.users.${config.modules.zsh.user}.shell = pkgs.zsh;
    };
  };

  flake.homeModules.zsh = {...}: {
    imports = [
      self.homeModules.zshOptions
      self.homeModules.zshAliases
      self.homeModules.zshFunctions
      self.homeModules.zshPrompt
    ];

    programs.zsh = {
      enable = true;
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.lsd.enable = true;
  };
}
