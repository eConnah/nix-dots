{ ... }: {
  flake.nixosModules.phoenix-hardware =
    {
      lib,
      modulesPath,
      pkgs,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      boot = {
        kernelModules = [
          "kvm-intel"
          "kvm-amd"
        ];
        extraModulePackages = [ ];
        initrd = {
          availableKernelModules = [
            "nvme"
            "xhci_pci"
            "ahci"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [ ];
          supportedFilesystems = [ "f2fs" ];
          systemd.services.wipe-root = {
            description = "Reformat root filesystem";
            wantedBy = [ "initrd.target" ];
            after = [ "dev-disk-by\\x2dpartlabel-disk\\x2dmain\\x2droot.device" ];
            before = [ "sysroot.mount" ];
            unitConfig.DefaultDependencies = "no";
            serviceConfig = {
              Type = "oneshot";
              ExecStart = "${pkgs.f2fs-tools}/bin/mkfs.f2fs -f -l root /dev/disk/by-partlabel/disk-main-root";
            };
          };
        };
      };
    };
}
