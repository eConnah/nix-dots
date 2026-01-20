{
  flake.modules.nixos.le-nix-filesystem = {
    fileSystems."/" = { 
      device = "/dev/disk/by-uuid/e1c62851-c063-4751-a53c-1ce398a85a78";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" ];
    };

    fileSystems."/home" = { 
      device = "/dev/disk/by-uuid/e1c62851-c063-4751-a53c-1ce398a85a78";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" ];
    };

    fileSystems."/nix" = { 
      device = "/dev/disk/by-uuid/e1c62851-c063-4751-a53c-1ce398a85a78";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime" ];
    };

    fileSystems."/swap" = {
      device = "/dev/disk/by-uuid/e1c62851-c063-4751-a53c-1ce398a85a78";
      fsType = "btrfs";
      options = [ "subvol=@swap" "noatime" ];
    };

    fileSystems."/boot" = { 
      device = "/dev/disk/by-uuid/7B05-1316";
      fsType = "vfat";
      options = [ "fmask=0177" "dmask=0077" ];
    };

    swapDevices = [ { device = "/swap/swapfile"; } ];
    
    boot.kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.max_pool_percent=20"
      "zswap.shrinker_enabled=1"
    ];
    boot.kernel.sysctl = { "vm.swappiness" = 70; };
  };
}
