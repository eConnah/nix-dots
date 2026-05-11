{ inputs, self, ... }:
{
  flake.nixosModules.onyxPreservation =
    { ... }:
    {
      imports = [ inputs.preservation.nixosModules.default ];
      
      boot.tmp.useTmpfs = false;
      boot.tmp.cleanOnBoot = true;

      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

      preservation = {
        enable = true;

        preserveAt."/persistent" = {
          # System-level persistence
          directories = [
            "/etc/nixos"
            "/etc/NetworkManager/system-connections"
            "/var/lib/bluetooth"
            "/var/lib/tailscale"
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

          # User-level persistence
          users.connor = {
            directories = [
              # Core User State
              "Desktop"
              "Documents"
              "Downloads"
              "Music"
              "Pictures"
              "Videos"
              ".ssh"
              ".local/share/keyrings"
              ".local/share/fish"

              # Application Data & Configs
              ".config/chromium"
              ".config/Code"
              ".config/halloy"
              ".config/JetBrains"
              ".config/libreoffice"
              ".config/obsidian"
              ".config/Signal"
              ".config/vesktop"

              # Application Local Share (Heavier Data)
              ".local/share/JetBrains"
              ".local/share/PrismLauncher"
              ".vscode"
              ".java"
            ];
          };
        };
      };
    };
}
