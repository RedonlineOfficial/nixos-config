{ self, inputs, ... }: {
  flake.nixosModules.disko-efiSingleLuksExt4 = { lib, config, ... }: let
    cfg = config.diskoOpts;
  in {
    imports = [ inputs.disko.nixosModules.disko ];
    options.diskoOpts = {
      device = lib.mkOption {
        type = lib.types.str;
        example = "/dev/nvme0n1";
        description = "The block device to use for the primary disk";
      };
    };
    config = {
      disko.devices = {
        disk = {
          main = {
            type = "disk";
            device = cfg.device; # Uses supplied device name
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  size = "500M";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                luks = {
                  size = "100%";
                  content = {
                    type = "luks";
                    name = "crypted";
                    settings.allowDiscards = true;
                    content = {
                      type = "filesystem";
                      format = "ext4";
                      mountpoint = "/";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
