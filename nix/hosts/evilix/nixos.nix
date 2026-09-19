{moduleWithSystem, ...}: {
  flake.nixosModules.evilix-config = moduleWithSystem (
    {self', ...}: {
      config,
      pkgs,
      lib,
      ...
    }: {
      boot = {
        kernelPackages = pkgs.linuxPackages_zen;
      };
      environment.systemPackages = [
        self'.packages.nvim-qwerty
      ];
      networking = {
        hostName = "evilix";
        dhcpcd.enable = false;
        useDHCP = false;
      };
      services.greetd.enable = lib.mkForce false;
      system.nixos-core.persistence.enable = lib.mkForce false;
      nix.settings = {
        cores = 0;
        http-connections = 100;
        max-jobs = 2;
        #secret-key-files = [config.security.nix-secrets.secrets."nix-cache-key".path];
      };
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      programs = {
        nh.flake = "/persistent/dotfiles";
      };
      security.nix-secrets = {
        enable = lib.mkForce false; # no gpg key has been made yet
        identityPaths = [
          "/persistent/nix-keys/age-identity.txt"
          "/persistent/nix-keys/yubikey-age.txt"
        ];
        storagePath = "/persistent/dotfiles/secrets";
      };
      services.pipewire.extraConfig.pipewire."92-custom-quantum" = {
        "context.properties" = {
          "default.clock.max-quantum" = 8192;
          "default.clock.min-quantum" = 512;
          "default.clock.quantum" = 512;
          "default.clock.rate" = 48000;
        };
      };
      time.timeZone = "Europe/Amsterdam";
      users = {
        mutableUsers = false;
        users.connor.password = "temp";
        #users.connor.hashedPasswordFile = config.security.nix-secrets.secrets."connor/linux".path;
      };
      wsl = {
        enable = true;
        defaultUser = "connor";
        interop.includePath = true;
        wslConf.automount.options = "metadata,uid=2026,gid=2026";
        startMenuLaunchers = true;
      };
      xdg.portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-gtk];
        config.common.default = ["gtk"];
      };
    }
  );
}
