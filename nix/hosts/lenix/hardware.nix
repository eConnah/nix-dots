{ ... }: {
  flake.nixosModules.lenix-hardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [ "uas" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "none";
        fsType = "tmpfs";
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/6f190059-8d44-4692-87d4-077ea4034697";
        fsType = "btrfs";
        options = [ "subvol=@nix" ];
      };

      fileSystems."/persistent" = {
        device = "/dev/disk/by-uuid/6f190059-8d44-4692-87d4-077ea4034697";
        fsType = "btrfs";
        options = [ "subvol=@persistent" ];
      };

      fileSystems."/snapshots" = {
        device = "/dev/disk/by-uuid/6f190059-8d44-4692-87d4-077ea4034697";
        fsType = "btrfs";
        options = [ "subvol=@snapshots" ];
      };

      fileSystems."/swap" = {
        device = "/dev/disk/by-uuid/6f190059-8d44-4692-87d4-077ea4034697";
        fsType = "btrfs";
        options = [ "subvol=@swap" ];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/33D3-16FC";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
    };
}
