{ inputs, ... }: {
  imports = [
    inputs.flake-file.flakeModules.default
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];

  systems = [
    "x86_64-linux"
  ];

}
