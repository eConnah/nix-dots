{ self, ... }: {
  flake.nixosModules.nvidia = {
    imports = [ self.nixosModules.mesa ];
    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
    };
    nix.settings = {
      substituters = [
        "https://cache.nixos-cuda.org"
      ];
      trusted-public-keys = [
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
    };
    nixpkgs.config.cudaSupport = true;
    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
