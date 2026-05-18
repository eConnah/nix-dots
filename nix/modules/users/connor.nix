{ inputs, self, ... }:
{
  flake.nixosModules.connor =
    { pkgs, ... }:
    {
      home-manager.users.connor = self.homeModules.connor;

      users.users.connor = {
        description = "Connor Alecks";
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };

      services.displayManager.autoLogin.user = "connor";

      services.tailscale = {
        enable = true;
        useRoutingFeatures = "client";
      };

      # yubikey stuff
      services.pcscd.enable = true;
      services.udev.packages = with pkgs; [
        yubikey-personalization
      ];
      environment.systemPackages = with pkgs; [
        yubikey-manager
      ];

      time.timeZone = "Europe/Amsterdam";
    };

  flake.homeModules.connor =
    { pkgs, ... }:
    {
      imports = [ self.homeModules.vicinae ];
      home.username = "connor";
      home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/connor" else "/home/connor";
      home.stateVersion = "25.05";

      # yubikey git setup
      programs.git = {
        settings = {
          user = {
            name = "Connor Alecks";
            email = "git@econnah.uk";
            signingkey = "~/.ssh/id_ed25519_sk_rk.pub";
          };

          commit = {
            gpgSign = true;
          };
          gpg = {
            format = "ssh";
          };
          pull = {
            ff = "only";
          };
          init = {
            defaultBranch = "main";
          };
          diff = {
            tool = "vimdiff";
          };
          core = {
            editor = "nvim";
          };
          push = {
            autoSetupRemote = true;
          };
        };
      };

      programs.ssh = {
        enableDefaultConfig = false;
        matchBlocks = {
          "github.com" = {
            user = "git";
            identityFile = "~/.ssh/id_ed25519_sk_rk";
            identitiesOnly = true;
          };
        };
      };

      home.packages = with pkgs; [
        halloy
        hyprcursor
        hyprpicker
        hyprshot
        jetbrains.idea
        libreoffice
        obsidian
        prismlauncher
        rose-pine-hyprcursor
        signal-desktop
        spotifyd
        vesktop
        vscode
      ];
    };
}
