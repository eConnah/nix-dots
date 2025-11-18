# Default options that everyone should use

{ vars, ... }:

{
  imports = [
    ../../hosts/${vars.host}/configuration.nix
    ./user-${vars.user}.nix
  ];

  boot.initrd.systemd.enable = true;

  networking.networkmanager.enable = true;
  
  nix.channel.enable = false;
  nix.settings.use-xdg-base-directories = true;
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;
  services.openssh.enable = true;

  services.displayManager = {
    autoLogin.enable = true;
    sddm.enable = true;
    sddm.theme = "catppuccin-mocha-mauve";
    sddm.wayland.enable = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.gamemode.enable = true;
  programs.git.enable = true;
  programs.neovim.enable = true;
}
