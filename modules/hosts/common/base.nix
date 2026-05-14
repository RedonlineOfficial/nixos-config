{ self, inputs, ... }: {
  flake.nixosModules.base = { pkgs, ... }: { 
    imports = [
      # Home Manager
      inputs.home-manager.nixosModules.home-manager 
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-bk";
      }
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
