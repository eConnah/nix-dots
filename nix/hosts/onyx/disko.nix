{ inputs, self, ... }:
{
  flake.nixosModules.onyxDisko =
    { ... }:
    {
      imports = [ inputs.disko.nixosModules.disko ];

      fileSystems."/nix".neededForBoot = true;
      fileSystems."/persistent".neededForBoot = true;

      disko.devices.nodev = {
        "/" = {
          fsType = "tmpfs";
          mountOptions = [
            "size=25%"
            "mode=755"
          ];
        };
      };

      disko.devices.disk.main = {
        device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S6B0NU0WA12347K";
        type = "disk";

        content.type = "gpt";

        content.partitions.esp = {
          name = "ESP";
          size = "5G";
          type = "EF00";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };

        content.partitions.root = {
          name = "root";
          size = "100%";

          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];

            subvolumes = {
              "/persistent" = {
                mountOptions = [
                  "subvol=persistent"
                  "compress=zstd:3"
                  "noatime"
                ];
                mountpoint = "/persistent";
              };

              "/nix" = {
                mountOptions = [
                  "subvol=nix"
                  "compress=zstd:3"
                  "noatime"
                ];
                mountpoint = "/nix";
              };

              "/tmp" = {
                mountOptions = [
                  "subvol=tmp"
                  "compress=zstd:3"
                  "noatime"
                ];
                mountpoint = "/tmp";
              };
            };
          };
        };
      };

      disko.devices.disk.hdd = {
        device = "/dev/disk/by-id/ata-ST2000LM015-2E8174_ZDZQ7T41";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            storage = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];

                subvolumes = {
                  "/data" = {
                    mountOptions = [
                      "subvol=data"
                      "compress=zstd:3"
                      "noatime"
                    ];
                    mountpoint = "/data";
                  };
                };
              };
            };
          };
        };
      };
    };
}
