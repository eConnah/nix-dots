{ inputs, self, ... }:
{
  flake.nixosModules.defaults =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.substituters
        inputs.home-manager.nixosModules.home-manager
      ];

      services.libinput.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      networking.networkmanager.enable = true;

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

      virtualisation = {
        docker = {
          enable = false;
          storageDriver = "btrfs";
          rootless = {
            enable = true;
            setSocketVariable = true;
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

      environment.systemPackages = with pkgs; [
        eza
        pavucontrol
        pulseaudio
        easyeffects
        alsa-utils
        qpwgraph
        liblc3
        kitty
        wget
        p7zip
        usbutils
        nixfmt-rfc-style
        fastfetch
        sshfs
        cryptsetup
      ];
    };
}
