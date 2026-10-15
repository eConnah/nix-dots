{
  flake.nixosModules.phoenix-hardware = {
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];
    boot = {
      initrd = {
        availableKernelModules = [
          "sd_mod"
          "virtio_blk"
          "virtio_pci"
          "virtio_scsi"
        ];
        systemd.services.rollback-void = {
          after = ["dev-disk-by\\x2dpartlabel-disk\\x2dmain\\x2droot.device"];
          before = ["sysroot.mount"];
          description = "Roll back @void root subvolume to blank snapshot";
          path = [
            pkgs.btrfs-progs
            pkgs.coreutils
            pkgs.gawk
            pkgs.util-linux
          ];
          script = ''
            mkdir -p /mnt
            mount /dev/disk/by-partlabel/disk-main-root /mnt
            for sub in $(btrfs subvolume list -o /mnt/@void 2>/dev/null | awk '{print $NF}' | sort -r); do
                btrfs subvolume delete "/mnt/$sub" || true
            done
            btrfs subvolume delete /mnt/@void
            btrfs subvolume snapshot /mnt/@void-blank /mnt/@void
            umount /mnt
          '';
          serviceConfig.Type = "oneshot";
          unitConfig.DefaultDependencies = "no";
          wantedBy = ["initrd.target"];
        };
      };
      kernelParams = ["console=ttyAMA0,115200"];
    };
    environment.etc."machine-id".text = "37b4b744492f46a28db8d0ffac48d8e8\n";
    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  };
}
