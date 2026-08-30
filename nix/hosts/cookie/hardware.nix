{
  flake.nixosModules.cookie-hardware = {
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    boot = {
      initrd = {
        availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "usb_storage"
          "sd_mod"
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
      kernelModules = [
        "kvm-amd"
      ];
    };
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
