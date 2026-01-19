{ inputs, ... }:
let
  hasAsahiBoot = builtins.pathExists "/boot/asahi";
in
{
  flake.modules.nixos.hardware-asahi = {
    imports = [
      inputs.nixos-apple-silicon.nixosModules.default
      inputs.self.modules.nixos.hardware-laptop
      inputs.self.modules.nixos.bootloader-limine
    ];

    nix.settings = {
      extra-substituters = [
        "https://nixos-apple-silicon.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
      ];
    };

    boot.extraModprobeConfig = ''
      options hid_apple iso_layout=0
    '';

    hardware.asahi.extractPeripheralFirmware = hasAsahiBoot;
    nixpkgs.config.allowUnsupportedSystem = true;
    boot.loader.efi.canTouchEfiVariables = false;

    virtualisation = {
      docker = {
        enable = false;
        storageDriver = "btrfs";
        rootless = {
          enable = true;
          setSocketVariable = true;
          daemon.settings = {
            registry-mirrors = [ "https://mirror.gcr.io" ];
          };
        };
      };
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };
  };
}
