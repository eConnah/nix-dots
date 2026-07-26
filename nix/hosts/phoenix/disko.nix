{ inputs, ... }: {
  flake.nixosModules.phoenix-disko = { ... }: {
    imports = [ inputs.disko.nixosModules.disko ];

    fileSystems = {
      "/persistent".neededForBoot = true;

      "/nix" = {
        device = "/persistent/nix";
        fsType = "none";
        options = [ "bind" ];
        neededForBoot = true;
      };
    };

    disko.devices.disk = {
      main = {
        device = "/dev/disk/by-id/nvme-WDC_PC_SN520_SDAPNUW-256G-1006_19525E800918";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              priority = 1;
              name = "ESP";
              size = "5G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            swap = {
              priority = 2;
              name = "swap";
              size = "12G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };

            root = {
              priority = 3;
              name = "root";
              size = "8G";
              content = {
                type = "filesystem";
                format = "f2fs";
                mountpoint = "/";
                extraArgs = [
                  "-f"
                  "-l"
                  "root"
                ];
                mountOptions = [ "noatime" ];
              };
            };

            persistent = {
              priority = 4;
              name = "persistent";
              size = "100%";
              content = {
                type = "filesystem";
                format = "f2fs";
                mountpoint = "/persistent";
                extraArgs = [
                  "-f"
                  "-l"
                  "persistent"
                ];
                mountOptions = [ "noatime" ];
              };
            };
          };
        };
      };

      secondary = {
        device = "/dev/disk/by-id/ata-Samsung_SSD_860_EVO_250GB_S4CJNZFN216585Y";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "f2fs";
                mountpoint = "/data";
                extraArgs = [
                  "-f"
                  "-l"
                  "data"
                ];
                mountOptions = [ "noatime" ];
              };
            };
          };
        };
      };
    };
  };
}
