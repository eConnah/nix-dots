{ inputs, ... }: {
  flake.nixosModules.nyx-disko = { ... }: {
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

    disko.devices.nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=25%"
          "mode=755"
        ];
      };
    };

    disko.devices.disk = {
      main = {
        device = "/dev/disk/by-id/ata-SanDisk_SDSSDH3_500G_21107B801252";
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

            persistent = {
              priority = 2;
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
        device = "/dev/disk/by-id/ata-TOSHIBA_DT01ACA100_897K99ANS";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "xfs";
                mountpoint = "/data";
                extraArgs = [
                  "-f"
                  "-L"
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
