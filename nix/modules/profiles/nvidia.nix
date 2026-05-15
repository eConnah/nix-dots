{ inputs, self, ... }:
{
  flake.nixosModules.nvidia =
    { ... }:
    {
      hardware.graphics.enable = true;
      hardware.nvidia.modesetting.enable = true;
      hardware.nvidia.open = true;
      services.xserver.videoDrivers = [ "nvidia" ];
    };
}
