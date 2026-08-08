{ ... }: {
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
              ".local/share/zoxide"
            ];
          }) normalUsers;
        };
      };
      security.sudo.extraConfig = "Defaults lecture=never";
      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    };
}
