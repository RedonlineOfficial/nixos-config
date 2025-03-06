{config, lib, ... }: let
  inherit (config) myNixos;
in {
  options = {
    myNixos = {
      username = lib.mkOption {
      	description = "The name of the primary user";
      	type = lib.types.str;
      };

      userFullName = lib.mkOption {
      	description = "The full name of the user";
      	type = lib.types.str;
      };

      homeDirectory = lib.mkOption {
      	description = "The path to the user's home directory";
      	type = lib.types.path;
      	default = /home/${myNixos.username};
      };

      hashedPassword = lib.mkOption {
      	description = "The hashed password for the user";
      	type = lib.types.str;
      };

      hostname = lib.mkOption {
      	description = "The systems hostname";
      	type = lib.types.str;
      };

      domain = lib.mkOption {
      	description = "The domain for the system";
      	type = lib.types.str;
      };

      isDesktop = lib.mkOption {
      	description = "Whether or not the system has a graphical user interface";
      	type = lib.types.bool;
      	default = false;
      };

      isLaptop = lib.mkOption {
      	description = "Whether or not the system is running on a laptop";
      	type = lib.types.bool;
      	default = false;
      };
    };
  };

  config = {};
}
