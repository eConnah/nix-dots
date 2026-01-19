{ inputs, ... }:
{
  flake.modules.nixos.system-default = {
    imports = [ inputs.self.modules.generic.system-default ];

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    services.displayManager.sddm = {
      enable = true;
      theme = "catppuccin-mocha-mauve";
      wayland.enable = true;
    };

    networking.networkmanager.enable = true;

    services.flatpak.enable = true;
    services.openssh.enable = true;

    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;

    nix.settings.auto-optimise-store = true;
    nix.settings.use-xdg-base-directories = true;
    nix.channel.enable = false;

    programs.gamemode.enable = true;
    programs.firefox.enable = true;

    system.stateVersion = "25.11";
  };
}
