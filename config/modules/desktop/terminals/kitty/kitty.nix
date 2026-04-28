{
  self,
  inputs,
  ...
}: {
  flake.homeModules.kitty = {pkgs, ...}: {
    programs.kitty = {
      enable = true;

      font = {
        name = "FiraCode Nerd Font";
        package = pkgs.fira-code;
        size = 10;
      };
    };
  };
}
