{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.defaults =
    {
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.lix-module.nixosModules.default
        inputs.preservation.nixosModules.default
        inputs.stylix.nixosModules.stylix
        self.nixosModules.substituters
      ];
      boot.zfs.forceImportRoot = lib.mkDefault false;
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
        hunspell
        hunspellDicts.en_GB-large
        hunspellDicts.fr-moderne
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
      fonts = {
        enableDefaultPackages = true;
        fontDir.enable = true;
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
      };
      nix.channel.enable = false;
      nix.settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-public-keys = [
          "lenix-cache:T6owlM58CGYc8X5xrAMq+IP6ilNWBpWlR8VazPPkjAQ="
          "onyx-cache:O+2Ad+2xMdljj1G8eH5KYQxdkixoEGUREXKTRV/BBKk="
          "phoenix-cache:YvJE4WPv95BDa8a7mTn83J1Oqib+3qpHOrztWpRLoPI="
        ];
        trusted-users = [
          "root"
          "@wheel"
        ];
        use-xdg-base-directories = true;
      };
      nixpkgs.config.allowUnfree = true;
      programs = {
        dconf.enable = true;
        firefox.enable = true;
        fish.enable = true;
        gamemode.enable = true;
        git.enable = true;
        gnupg.agent = {
          enable = true;
          enableSSHSupport = false;
        };
        nh = {
          enable = true;
          clean.enable = true;
          clean.extraArgs = "--keep-since 4d --keep 10";
        };
        seahorse.enable = true;
        ssh.startAgent = true;
      };
      security.rtkit.enable = true;
      services = {
        flatpak.enable = lib.mkDefault true;
        gnome = {
          gcr-ssh-agent.enable = false;
          gnome-keyring.enable = true;
        };
        libinput.enable = true;
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
      virtualisation = {
        # when I want to build a system vm
        vmVariant = {
          boot.kernelParams = [ "video=2560x1440@240" ];
          virtualisation.cores = 4;
          virtualisation.memorySize = 10240;
        };
      };
      xdg.mime = {
        enable = true;
        defaultApplications = {
          "x-scheme-handler/terminal" = "kitty.desktop";
        };
      };
    };
}
