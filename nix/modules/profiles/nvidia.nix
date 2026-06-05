{ inputs, self, ... }:
{
  flake.nixosModules.nvidia =
    { ... }:
    {
      hardware.nvidia.modesetting.enable = true;
      hardware.nvidia.open = true;
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
}
