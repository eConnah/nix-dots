{ inputs, ... }:
{
  flake.modules.nixos.onix = {
    
    imports = [
      inputs.self.modules.nixos.system-default
      inputs.self.modules.nixos.storage-onix 
      inputs.self.modules.nixos.user-connor
      inputs.self.modules.nixos.hardware-onix
      inputs.self.modules.nixos.desktop-hyprland
      inputs.self.modules.nixos.tool-tailscale
      inputs.self.modules.nixos.bootloader-limine
    ];

    networking.hostName = "onix";
  };
}