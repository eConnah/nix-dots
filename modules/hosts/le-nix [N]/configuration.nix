{ inputs, ... }:
{
  flake.modules.nixos.le-nix = { pkgs, ... }: {
    imports = [
      inputs.self.modules.nixos.system-default
      inputs.self.modules.nixos.user-connor
      inputs.self.modules.nixos.hardware-asahi
      inputs.self.modules.nixos.le-nix-filesystem 
      inputs.self.modules.nixos.le-nix-hardware
      inputs.self.modules.nixos.desktop-hyprland
      inputs.self.modules.nixos.tool-tailscale
    ];

    networking.hostName = "le-nix";

    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "connor";

    boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
    nix.settings.extra-platforms = [ "x86_64-linux" ];

    environment.systemPackages = with pkgs; [
      distrobox
      matugen
      gh
      brightnessctl
      liblc3
      mpv
    ];

    home-manager.users.connor = [
      inputs.self.modules.nixos.hyprland-config
    ];
  };
}
