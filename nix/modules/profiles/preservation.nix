{ inputs, ... }: {
  flake.nixosModules.preservation = { ... }: {
    imports = [
      inputs.preservation.nixosModules.default
    ];

    boot.tmp.useTmpfs = false;
    boot.tmp.cleanOnBoot = true;

    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    security.sudo.extraConfig = "Defaults lecture=never";

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
  };
}
