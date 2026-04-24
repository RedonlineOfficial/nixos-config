{
  self,
  inputs,
  ...
}: {
  flake.homeModules.joshuaHome = {...}: {
    imports = [
      self.homeModules.profilesCommon
    ];
    home.username = "joshua";
    home.homeDirectory = "/home/joshua";
    home.stateVersion = "25.11";

    programs.home-manager.enable = true;
  };
}
