{moduleWithSystem, ...}: {
  flake.nixosModules.evilix-config = moduleWithSystem (
    {self', ...}: {
      pkgs,
      lib,
      ...
    }: {
      environment = {
        etc."wsl-session-init.sh" = {
          mode = "0755";
          text = ''
            #!${pkgs.runtimeShell}
            systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_RUNTIME_DIR
            systemctl --user start graphical-session.target
            exec ${pkgs.fish}/bin/fish -l
          '';
        };
        sessionVariables.LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
        systemPackages = with pkgs; [
          self'.packages.nvim-qwerty
          python3
        ];
      };
      networking = {
        hostName = "evilix";
        dhcpcd.enable = false;
        useDHCP = false;
      };
      security.soteria.enable = lib.mkForce false;
      services.greetd.enable = lib.mkForce false;
      system.nixos-core.persistence.enable = lib.mkForce false;
      systemd.user.targets = {
        "graphical-session".unitConfig.RefuseManualStart = false;
        "graphical-session-pre".unitConfig.RefuseManualStart = false;
      };
      nix.settings = {
        cores = 0;
        http-connections = 100;
        max-jobs = 2;
      };
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      programs = {
        fish.shellInit = ''
          set -gx DOTNET_ROOT $HOME/.dotnet
          fish_add_path $HOME/.dotnet
        '';
        nh.flake = "/persistent/dotfiles";
        nix-ld = {
          enable = true;
          libraries = with pkgs; [
            stdenv.cc.cc
            stdenv.cc.libc
            zlib
            icu
            openssl
            curl
            libgcc
          ];
        };
        steam.enable = false;
      };
      security.nix-secrets.enable = lib.mkForce false;
      time.timeZone = "Europe/Amsterdam";
      users = {
        mutableUsers = false;
        users.connor = {
          password = "temp";
          extraGroups = ["render" "video"];
          #hashedPasswordFile = "/persistent/secret/connor/linux";
        };
      };
      wsl = {
        enable = true;
        defaultUser = "connor";
        interop.includePath = false;
        ssh-agent.enable = true;
        startMenuLaunchers = true;
        useWindowsDriver = true;
        wslConf.automount.options = "metadata,uid=2026,gid=2026";
      };
      xdg.portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-gtk];
        config.common.default = ["gtk"];
      };
    }
  );
}
