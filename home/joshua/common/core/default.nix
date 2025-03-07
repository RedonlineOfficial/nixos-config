{ lib, ... }: {
  imports = [
    (map lib.custom.relativeToRoot [
      "modules/home-manager"
    ])
  ];

  programs.home-manager.enable = true;

}
