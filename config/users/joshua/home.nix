{
  self,
  inputs,
  ...
}: {
  flake.homeModules.joshuaHome = {pkgs, ...}: {
    imports = [
      self.homeModules.profilesCommon
    ];
    home.username = "joshua";
    home.homeDirectory = "/home/joshua";
    home.stateVersion = "25.11";

    home.packages = [
      pkgs.claude-code
    ];

    programs.home-manager.enable = true;
  };
}
