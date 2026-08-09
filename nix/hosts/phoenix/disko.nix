{ inputs, ... }: {
  flake.nixosModules.phoenix-disko = {
    imports = [ inputs.disko.nixosModules.disko ];
    disko.devices.disk = {
      main = {
        content = {
          partitions = {
            esp = {
              content = {
                format = "vfat";
                mountOptions = [ "umask=0077" ];
                mountpoint = "/boot";
                type = "filesystem";
              };
              name = "ESP";
              priority = 1;
              size = "5G";
              type = "EF00";
            };
            persistent = {
              content = {
                extraArgs = [
                  "-f"
                  "-l"
                  "persistent"
                ];
                format = "f2fs";
                mountOptions = [ "noatime" ];
                mountpoint = "/persistent";
                type = "filesystem";
              };
              name = "persistent";
              priority = 4;
              size = "100%";
            };
            root = {
              content = {
                extraArgs = [
                  "-f"
                  "-l"
                  "root"
                ];
                format = "f2fs";
                mountOptions = [ "noatime" ];
                mountpoint = "/";
                type = "filesystem";
              };
              name = "root";
              priority = 3;
              size = "8G";
            };
            swap = {
              content = {
                resumeDevice = true;
                type = "swap";
              };
              name = "swap";
              priority = 2;
              size = "12G";
            };
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/nvme-WDC_PC_SN520_SDAPNUW-256G-1006_19525E800918";
        type = "disk";
      };

      secondary = {
        content = {
          partitions = {
            data = {
              content = {
                extraArgs = [
                  "-f"
                  "-l"
                  "data"
                ];
                format = "f2fs";
                mountOptions = [ "noatime" ];
                mountpoint = "/data";
                type = "filesystem";
              };
              size = "100%";
            };
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/ata-Samsung_SSD_860_EVO_250GB_S4CJNZFN216585Y";
        type = "disk";
      };
    };
    fileSystems = {
      "/nix" = {
        options = [ "bind" ];
        device = "/persistent/nix";
        fsType = "none";
        neededForBoot = true;
      };
      "/persistent".neededForBoot = true;
    };
  };
}
