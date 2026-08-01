{ inputs, ... }: {
  flake.nixosModules.nyx-disko = { ... }: {
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
              priority = 2;
              size = "100%";
            };
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/ata-SanDisk_SDSSDH3_500G_21107B801252";
        type = "disk";
      };

      secondary = {
        content = {
          partitions = {
            data = {
              content = {
                extraArgs = [
                  "-f"
                  "-L"
                  "data"
                ];
                format = "xfs";
                mountOptions = [ "noatime" ];
                mountpoint = "/data";
                type = "filesystem";
              };
              size = "100%";
            };
          };
          type = "gpt";
        };
        device = "/dev/disk/by-id/ata-TOSHIBA_DT01ACA100_897K99ANS";
        type = "disk";
      };
    };
    disko.devices.nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=25%"
          "mode=755"
        ];
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
