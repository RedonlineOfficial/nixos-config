{ lib, ... }: {
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/home-manager"
    ])
  ];

  programs.home-manager.enable = true;

}
