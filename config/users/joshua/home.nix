{ self, inputs, ... }: {
  flake.homeModules.userJoshuaHome = { ... }: {
    home.username = "joshua";
    home.homeDirectory = "/home/joshua";
    home.stateVersion = "25.11";

    programs.home-manager.enable = true;
  };
}
