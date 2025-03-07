{ config, lib, inputs, outputs, pkgs, ... }: let
  inherit (config) myNixos;
in {
  imports = lib.flatten [
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager

    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/nixos"
    ])
  ];

  # --- Nix --- #
  nix = {
    gc = {
      automatic = true;
      dates = "Wed, 03:00";
    };

    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Cache
      connect-timeout = 5;
      fallback = true;

      # GC/Optimise
      min-free = 1000000000; # 1GB
      max-free = 5000000000; # 5GB

      auto-optimise-store = true;

      # Misc
      warn-dirty = false;
      trusted-users = ["@wheel"];
      experimental-features = ["nix-command" "flakes"];
    };
  };

  # --- Nixpkgs --- #
  nixpkgs = {
    overlays = [ outputs.overlays.default ];
    config.allowUnfree = true;
  };

  # --- Bootloader --- #
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
  };

  # --- Networking --- #
  networking = {
    hostName = myNixos.hostname;
    domain = myNixos.domain;

    firewall = {
      enable = true;
    };

    networkmanager.enable = true;
  };

  # --- Locale --- #
  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";

  # --- Users --- #
  users.users = {
    ${myNixos.username} = {
      name = myNixos.username;
      description = myNixos.userFullName;
      hashedPassword = myNixos.hashedPassword;
      home = myNixos.homeDirectory;
      createHome = true;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };
  };

  # --- Home-manager --- #
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bk";
    extraSpecialArgs = { 
      inherit inputs pkgs;
      inherit (config) myNixos;
    };

    users.${myNixos.username} = import (lib.custom.relativeToRoot "home/${myNixos.username}/${myNixos.hostname}.nix");
  };
}
