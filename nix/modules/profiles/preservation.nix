{
  flake.nixosModules.preservation =
    {
      config,
      lib,
      ...
    }:
    let
      normalUsers = lib.filterAttrs (_name: user: user.isNormalUser) config.users.users;
    in
    {
      boot.tmp.cleanOnBoot = true;
      boot.tmp.useTmpfs = false;
      preservation = {
        enable = true;

        preserveAt."/persistent" = {
          directories = [
            "/etc/nixos"
            "/etc/ssh"
            "/var/lib/flatpak"
            "/var/lib/tailscale"
            "/var/log"
            {
              directory = "/var/lib/nixos";
              inInitrd = true;
            }
          ];

          files = [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
          ];

          users = lib.mapAttrs (_name: _: {
            directories = [
              ".cache/bat"
              ".config/Signal"
              ".config/easyeffects"
              ".config/jj/repos"
              ".config/vesktop"
              ".local/share/applications"
              ".local/share/fish"
              ".local/share/flatpak"
              ".local/share/icons"
              ".local/share/keyrings"
              ".local/share/nvim"
              ".local/share/zoxide"
              ".local/state/wireplumber"
              ".ssh"
              ".var/app"
              "Desktop"
              "Documents"
              "Downloads"
              "Music"
              "Pictures"
              "Videos"
            ];
          }) normalUsers;
        };
      };
      security.sudo.extraConfig = "Defaults lecture=never";
      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    };
}
