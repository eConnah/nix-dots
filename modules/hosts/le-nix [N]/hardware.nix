{ ... }:
{
  flake.modules.nixos.le-nix-hardware =
    { modulesPath, ... }:
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot.initrd.availableKernelModules = [ "uas" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];

      services.libinput.enable = true;

      nixpkgs.hostPlatform = "aarch64-linux";
    };
}
