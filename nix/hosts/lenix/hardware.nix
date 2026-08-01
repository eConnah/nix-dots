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
      boot.extraModulePackages = [ ];
      boot.initrd.availableKernelModules = [ "uas" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      fileSystems."/" = {
        device = "none";
        fsType = "tmpfs";
      };
      fileSystems."/boot" = {
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
        device = "/dev/disk/by-uuid/33D3-16FC";
        fsType = "vfat";
      };
      fileSystems."/nix" = {
        options = [ "subvol=@nix" ];
        device = "/dev/disk/by-uuid/6f190059-8d44-4692-87d4-077ea4034697";
        fsType = "btrfs";
      };
      fileSystems."/persistent" = {
        options = [ "subvol=@persistent" ];
        device = "/dev/disk/by-uuid/6f190059-8d44-4692-87d4-077ea4034697";
        fsType = "btrfs";
      };
      fileSystems."/snapshots" = {
        options = [ "subvol=@snapshots" ];
        device = "/dev/disk/by-uuid/6f190059-8d44-4692-87d4-077ea4034697";
        fsType = "btrfs";
      };
      fileSystems."/swap" = {
        options = [ "subvol=@swap" ];
        device = "/dev/disk/by-uuid/6f190059-8d44-4692-87d4-077ea4034697";
        fsType = "btrfs";
      };
      nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
      swapDevices = [ ];
    };
}
