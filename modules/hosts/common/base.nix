{ self, inputs, ... }: {
  flake-file.inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nixpkgs stable fallback
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    # Nix hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # Dendritic Tools
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-file.url = "github:denful/flake-file";
    import-tree.url = "github:denful/import-tree";

    # Home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  flake-file.outputs = # nix
  ''
    inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } { 
      imports = [ 
        (inputs.import-tree ./modules) 
        inputs.home-manager.flakeModules.default 
      ]; 
    };
  '';

  flake.nixosModules.base = { pkgs, ... }: { 
    imports = [
      # Home Manager
      inputs.home-manager.nixosModules.home-manager 
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-bk";
      }

      inputs.nixos-hardware.nixosModules.common-pc
    ];

    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      kernelPackages = pkgs.linuxPackages_latest;
    };

    time.timeZone = "America/Phoenix";
    i18n.defaultLocale = "en_US.UTF-8";

    nixpkgs.config = {
      allowUnfree = true;
    };

    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
      };
    };

    environment.variables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_CACHE_HOME = "$HOME/.local/cache";
    };

    environment.systemPackages = with pkgs; [
      neovim
      git
    ];
  };
}
