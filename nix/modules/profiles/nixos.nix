{ inputs, self, ... }:
{
  flake.nixosModules.defaults =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.substituters
        inputs.home-manager.nixosModules.home-manager
      ];
      boot.zfs.forceImportRoot = lib.mkDefault false;

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

      programs.dconf.enable = true;
      programs.firefox.enable = true;
      programs.fish.enable = true;
      programs.gamemode.enable = true;
      programs.git.enable = true;
      programs.neovim.enable = true;
      programs.seahorse.enable = true;
      programs.ssh.startAgent = true;

      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = false;
      };
      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 10";
      };

      services.flatpak.enable = lib.mkDefault true;
      services.libinput.enable = true;

      services.gnome = {
        gnome-keyring.enable = true;
        gcr-ssh-agent.enable = false;
      };
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
        };
      };
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };

      security.rtkit.enable = true;

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

      xdg.mime = {
        enable = true;
        defaultApplications = {
          "x-scheme-handler/terminal" = "kitty.desktop";
        };
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

        # when I want to build a system vm
        vmVariant = {
          virtualisation.memorySize = 10240;
          virtualisation.cores = 4;
          boot.kernelParams = [ "video=2560x1440@240" ];
        };
      };

      environment.systemPackages = with pkgs; [
        (mpv.override { youtubeSupport = false; })
        alsa-utils
        atool
        cryptsetup
        distrobox
        e2fsprogs
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
        nixfmt
        nixfmt-tree
        p7zip
        pavucontrol
        pulseaudio
        qpwgraph
        sshfs
        tree
        usbutils
        wget
        wl-clipboard
        zulu
      ];
    };
}
