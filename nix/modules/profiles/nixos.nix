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
      environment = {
        sessionVariables.MANPAGER = "bat -plman";
        systemPackages = with pkgs; [
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
      };
      fonts = {
        enableDefaultPackages = false;
        fontDir.enable = true;
        fontconfig = {
          enable = true;
          defaultFonts = {
            emoji = [ "Noto Color Emoji" ];
            monospace = [ "Atkinson Hyperlegible Mono" ];
            sansSerif = [ "Atkinson Hyperlegible Next" ];
            serif = [ "Merriweather" ];
          };
        };
        packages = with pkgs; [
          atkinson-hyperlegible-mono
          atkinson-hyperlegible-next
          liberation_ttf
          merriweather
          nerd-fonts.jetbrains-mono
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
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
            ACE = "age1qa58lk685uwd9s8g3evvh9kyaf48rj0pggnsx6gc8nza4redx52qgrqyc0";
            escapepod3 = "age1REPLACE_ME";
            lenix = "age1xpg656d826awgldew9svunr9r4r8rdmf8fz7zgjlgmpd809q5flsavsmkd";
            murtle = "age1eqm8wgfpc8aawaxardpypg5gcdluavplfy7gn2qp9tefwauezs2sd69wvl";
            onyx = "age1vx67nthmpprcv7mws3rvp6wtqe23td8rkxvexhvay0gvsqse0saqquv2fe";
            turtle = "age1REPLACE_ME";
          };
          secrets."nix-cache-key".recipients = [
            "lenix"
            "onyx"
            "ACE"
            "murtle"
          ];
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
