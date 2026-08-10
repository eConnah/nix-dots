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
        inputs.hjem.nixosModules.default
        inputs.lix-module.nixosModules.default
        inputs.nix-secrets.nixosModules.default
        inputs.preservation.nixosModules.default
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
        firefox
        gh
        gimp
        gnome-keyring
        httpie
        hunspell
        hunspellDicts.en_GB-large
        hunspellDicts.fr-moderne
        hy
        imv
        jujutsu
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
      hjem = {
        clobberByDefault = true;
        extraModules = [ inputs.hjem-rum.hjemModules.default ];
      };
      nix.channel.enable = false;
      nix.settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-public-keys = [
          "lecache:T6owlM58CGYc8X5xrAMq+IP6ilNWBpWlR8VazPPkjAQ="
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
        bat.enable = true;
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
        zoxide = {
          enable = true;
          enableFishIntegration = true;
          flags = [
            "--cmd cd"
          ];
        };
      };
      security = {
        nix-secrets = {
          enable = true;
          recipientAliases = {
            escapepod3 = "age1REPLACE_ME";
            lenix = "age1xpg656d826awgldew9svunr9r4r8rdmf8fz7zgjlgmpd809q5flsavsmkd";
            nyx = "age1REPLACE_ME";
            onyx = "age1REPLACE_ME";
            phoenix = "age1REPLACE_ME";
          };
          secrets."nix-cache-key".recipients = [ "lenix" ]; # will become [ "lenix" "onyx" "phoenix" ] via rekey later
          storage = self + "/secrets";
        };
        rtkit.enable = true;
      };
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
      system.stateVersion = "25.11";
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
