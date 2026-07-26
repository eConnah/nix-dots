{ self, ... }: {
  flake.nixosModules.nvidia = { ... }: {
    imports = [ self.nixosModules.mesa ];

    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
    };
    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
