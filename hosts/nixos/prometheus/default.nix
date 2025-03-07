{ config, lib, inputs, ... }: let 
  inherit (config) myNixos;
in {
  imports = lib.flatten [
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-yoga

    ./hardware-configuration.nix

    (map lib.custom.relativeToRoot [
      # --- Required Modules --- #
      # Core Configuration
      "hosts/common/core"

      # Disko Layout
      "hosts/common/disks/luks-ext4.nix"

      # --- Optional Modules --- #
      "hosts/common/optional/desktops/hyprland.nix"
      "hosts/common/optional/hardware/displayLink.nix"
    ])
  ];

  myNixos = {
    hostname = "prometheus";
    domain = "lan.redonline.me";
    isDesktop = true;
    isLaptop = true;

    username = "joshua";
    userFullName = "Joshua Myers";
    homeDirectory = /home/joshua;
    hashedPassword = "$y$j9T$znk1fsAZICHGvKfmpJ.YW0$Tmuri1LBVKz/NhX4BkkPs6ga1yeSNMYiY3wciTwkgk4";
  };


}
