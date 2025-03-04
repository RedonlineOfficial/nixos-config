{ config, lib, inputs, outputs, pkgs, ... }: let 
  inherit (config) myNix;

  # Small function that takes a list as an input and filters out that list against matching user groups
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

in {

  # --- Global Modules --- #
  imports = [
    # - Inputs - #
    # We import our modules here since they will be used globally
    inputs.home-manager.nixosModules.home-manager 
    inputs.disko.nixosModules.disko

    # - Configs - #
    ./ssh.nix # Common ssh configs
    #./packages.nix # Not implemented yet

    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/nixos"
    ])
  ];

  # --- Nix Settings --- #
  nix = {
    # This adds each input as a registry
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    # We can also add our inputs to the legacy channels
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # - Cache - #
      connect-timeout = 5; # Time in seconds for nixos to timeout when connecting to binary cache
      fallback = true; # If it times out, does it fail or fallback

      # - Garbage Collection / Optimization - #
      min-free = 1000000000; # Runs garbage collection at 1GB free space remaining
      max-free = 5000000000; # Will clear until 5Gb of free space is remaining
      auto-optimize-store = true; # Everytime the system builds, it deduplicates itself

      # Miscellaneous
      trusted-users = [ "@wheel" ]; # Sudoers get elevated permissions with nix commands
      warn-dirty = false; # This is a useful feature, but I don't really want it in my build log
      experimental-features = [ "nix-command" "flakes" ]; # We enable flake support

    };
  };

  # --- Nixpkgs --- #
  nixpkgs = {
    overlays = [ outputs.overlays.default ]; # Add our overlays
    config.allowUnfree = true; # And allow unfree packages
  };

  # --- Bootloader --- #
  boot.loader = {
    grub = { # Because we use disko, we use grub so it can suport both gpt and dos style partition tables
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };

  # --- Networking --- #
  networking = {
    hostName = myNix.myHostname; # We set our hostname dynamically 
    domain = myNix.myDomain; # We also set our domain name dynamically

    firewall = {
      enable = true; # Enables a basic firewall.  TODO: find what ports I should have open globally if any.
    };

    networkmanager = {
      enable = true; # IMO this should be enabled by default
    };
  };

  # --- Locale --- #

  time.timeZone = "America/Phoenix"; # Our timezone, I don't plan on moving, so no reason not to set it globally
  i18n.defaultLocale = "en_US.UTF-8"; # Our locale, I don't plan on switching my primary language so no reason to not set it globally

  # --- Users --- #
  users.users.${myNix.myUsername} = { # This entire block will dynamically create our nixos user.  
    description = myNix.myFullName;
    hashedPassword = myNix.myHashedPassword;
    isNormalUser = true;
    extraGroups = lib.flatten [
      "wheel"
      (ifTheyExist [ # This is the script in the let expression.  We always want wheel but these others might not exist on all systems, so we check for them first
      	"networkmanager"
      ])
    ];
  };

  # --- Home-manager --- #
  home-manager = { # Because Nixos gathers all options in a configuration and reads it as one big file, we can 
    useGlobalPkgs = true; # technically setup home-manager anywhere on Nixos.  So we set it up here,
    useUserPackages = true; # and define our options dynamically.
    backupFileExtension = "bk";
    extraSpecialArgs = {
      inherit inputs pkgs;
      inherit (config) myNix;
    };
    users.${myNix.myHostname} = import (lib.custom.relativeToRoot "home/${myNix.myUsername}/${myNix.myHostname}.nix") { inherit config lib inputs pkgs myNix; };
  };
}
