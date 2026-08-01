{ ... }: {
  flake.nixosModules.preservation = { ... }: {
    boot.tmp.cleanOnBoot = true;
    boot.tmp.useTmpfs = false;
    preservation = {
      enable = true;

      preserveAt."/persistent" = {
        # System-level persistence
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
      };
    };
    security.sudo.extraConfig = "Defaults lecture=never";
    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  };
}
