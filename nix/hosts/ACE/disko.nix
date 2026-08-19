{ inputs, ... }: {
  flake.nixosModules.ACE-disko = {
    imports = [ inputs.disko.nixosModules.disko ];
    disko.devices.disk.main = {
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
              postMountHook = ''
                mkdir -p /mnt/persistent/nix
                mkdir -p /mnt/nix
                mount --bind /mnt/persistent/nix /mnt/nix
              '';
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
      device = "/dev/disk/by-id/ata-Micron_1300_MTFDDAV256TDL_2006266A1573";
      type = "disk";
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
