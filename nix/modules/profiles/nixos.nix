{ inputs, self, ... }:
{
  flake.nixosModules.defaults =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.substituters
        inputs.home-manager.nixosModules.home-manager
      ];

      nix.channel.enable = false;
      nix.settings.auto-optimise-store = true;
      nix.settings.use-xdg-base-directories = true;
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nix.settings.trusted-users = [
        "root"
        "@wheel"
      ];

      programs.firefox.enable = true;
      programs.fish.enable = true;
      programs.gamemode.enable = true;
      programs.git.enable = true;
      programs.neovim.enable = true;
      programs.seahorse.enable = true;

      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 10";
      };

      services.flatpak.enable = true;
      services.gnome.gnome-keyring.enable = true;
      services.libinput.enable = true;
      services.openssh.enable = true;

      services.pipewire = {
        enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };

      fonts = {
        fontconfig = {
          enable = true;
          defaultFonts = {
            sansSerif = [ "Roboto" ];
            monospace = [ "Roboto Mono" ];
          };
        };

        packages = with pkgs; [
          liberation_ttf
          nerd-fonts.jetbrains-mono
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
          roboto
          ubuntu-classic
        ];

        enableDefaultPackages = true;
        fontDir.enable = true;
      };

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
        alsa-utils
        atool
        cryptsetup
        distrobox
        e2fsprogs
        easyeffects
        eza
        fastfetch
        gh
        gimp
        httpie
        hy
        kitty
        libinput
        liblc3
        liblc3
        matugen
        (mpv.override { youtubeSupport = false; })
        nixfmt
        p7zip
        pavucontrol
        pulseaudio
        qpwgraph
        sshfs
        usbutils
        wget
        wl-clipboard
        zulu
      ];
    };
}
