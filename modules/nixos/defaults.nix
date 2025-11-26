# Default options that everyone should use

{ vars, pkgs, home-manager, ... }:

{
  imports = [
    ../../hosts/${vars.host}/configuration.nix
    ./user-${vars.user}.nix
  ];
  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  boot.initrd.systemd.enable = true;

  networking.networkmanager.enable = true;
  networking.hostName = "${vars.host}";

  nix.channel.enable = false;
  nix.settings.use-xdg-base-directories = true;
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.gnome.gnome-keyring.enable = true;

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

  programs.seahorse.enable = true;
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.gamemode.enable = true;
  programs.git.enable = true;
  programs.neovim.enable = true;
  
  nix.settings = {
    extra-substituters = [
      "https://vicinae.cachix.org"
    ];
    extra-trusted-public-keys = [
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };
  
  environment.systemPackages = with pkgs; [
    eza
    pavucontrol
    pulseaudio
    easyeffects
    qpwgraph
    liblc3
    kitty
    wget
    p7zip
    usbutils
    nixfmt-rfc-style
    fastfetch
  ];
}
