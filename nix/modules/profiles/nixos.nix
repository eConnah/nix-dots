{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.defaults =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.preservation.nixosModules.default
        inputs.stylix.nixosModules.stylix
        self.nixosModules.substituters
      ];
      boot.zfs.forceImportRoot = lib.mkDefault false;

      nix.channel.enable = false;
      nixpkgs.config.allowUnfree = true;

      nix.settings = {
        auto-optimise-store = true;
        use-xdg-base-directories = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        trusted-users = [
          "root"
          "@wheel"
        ];

        trusted-public-keys = [
          "lenix-cache:T6owlM58CGYc8X5xrAMq+IP6ilNWBpWlR8VazPPkjAQ="
          "onyx-cache:O+2Ad+2xMdljj1G8eH5KYQxdkixoEGUREXKTRV/BBKk="
          "phoenix-cache:YvJE4WPv95BDa8a7mTn83J1Oqib+3qpHOrztWpRLoPI="
        ];
      };

      programs = {
        dconf.enable = true;
        firefox.enable = true;
        fish.enable = true;
        gamemode.enable = true;
        git.enable = true;
        seahorse.enable = true;
        ssh.startAgent = true;

        gnupg.agent = {
          enable = true;
          enableSSHSupport = false;
        };
        nh = {
          enable = true;
          clean.enable = true;
          clean.extraArgs = "--keep-since 4d --keep 10";
        };
      };

      services = {
        flatpak.enable = lib.mkDefault true;
        libinput.enable = true;

        gnome = {
          gnome-keyring.enable = true;
          gcr-ssh-agent.enable = false;
        };
        openssh = {
          enable = true;
          settings = {
            PermitRootLogin = "no";
          };
        };
        pipewire = {
          enable = true;
          pulse.enable = true;
          wireplumber.enable = true;
        };
      };

      security.rtkit.enable = true;

      fonts = {
        fontconfig = {
          enable = true;
        };

        # fallback fonts main fonts are done with stylix
        packages = with pkgs; [
          liberation_ttf
          nerd-fonts.jetbrains-mono
          noto-fonts
          noto-fonts-cjk-sans
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
        file
        gh
        gimp
        httpie
        hy
        libinput
        liblc3
        matugen
        mesa-demos
        nixfmt
        nixfmt-tree
        p7zip
        patchelf
        pavucontrol
        pulseaudio
        qpwgraph
        sshfs
        tree
        usbutils
        vulkan-tools
        wget
        wl-clipboard
        zulu
      ];
    };
}
