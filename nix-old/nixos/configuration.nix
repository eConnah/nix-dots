# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Include the necessary packages and configuration for Apple Silicon support.
      <apple-silicon-support/apple-silicon-support>
      
      # Home-Manager 
      <home-manager/nixos>
    ];
  
  boot.loader.limine = {
    enable = true;
    extraConfig = ''
      term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
      term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
      term_background: 1e1e2e
      term_foreground: cdd6f4
      term_background_bright: 585b70
      term_foreground_bright: cdd6f4
    '';
    style.wallpapers = [ ];
  };

  boot.loader.efi.canTouchEfiVariables = false;
  boot.initrd.systemd.enable = true;
  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';

  #boot.kernelParams = [ "apple_dcp.show_notch=1" ];

  powerManagement.enable = true;

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
    "/var/log".options = [ "compress=zstd" ];
    "/var/cache".options = [ "noatime" ];
  };

  # Allow macos system
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnsupportedSystem = true;
  nix.settings.auto-optimise-store = true;
  
  # Enable bluetooth
  hardware.bluetooth.enable = true;

  networking.hostName = "escapepod3"; # Define your hostname.
  
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";
   
  # Laptop power stuff
  services.logind.settings.Login.HandleLidSwitch = "suspend";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  
  virtualisation = {
    docker = {
      enable = false;
      storageDriver = "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
        # Optionally customize rootless Docker daemon settings
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.leo = {
    isNormalUser = true;
    description = "Leo Chittock";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  
  # Setup Services
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
  
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    sddm.theme = "catppuccin-mocha-mauve";
    autoLogin.enable = true;
    autoLogin.user = "leo";
  };
  
  services.power-profiles-daemon.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.libinput.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Setup deeper? packages
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };

  programs.gamemode.enable = true;
  programs.firefox.enable = true;
  programs.neovim.enable = true;
  programs.git.enable = true;
  programs.fish.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    distrobox
    wget
    kitty
    matugen
    usbutils
    gh
    brightnessctl
    e2fsprogs
    p7zip
    easyeffects
    pulseaudio
    liblc3
    pavucontrol
    mpv
    plex-mpv-shim
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
      font  = "Noto Sans";
      fontSize = "9";
    })
  ];

  home-manager.users.leo = import ./homes/leo/home.nix;
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
