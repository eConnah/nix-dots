{ inputs, self, ... }:
{
  flake.nixosModules.onyxPreservation =
    { ... }:
    {
      imports = [ inputs.preservation.nixosModules.default ];

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
              ".local/share/applications"
              ".local/share/fish"
              ".local/share/keyrings"
              ".local/state/wireplumber"
              ".ssh"
              "Desktop"
              "Documents"
              "Downloads"
              "Music"
              "Pictures"
              "Videos"

              # Application Data & Configs
              ".config/Code"
              ".config/JetBrains"
              ".config/Signal"
              ".config/easyeffects"
              ".config/halloy"
              ".config/libreoffice"
              ".config/mozilla"
              ".config/obsidian"
              ".config/spotify"
              ".config/vesktop"
              ".config/vicinae"
              ".steam"
              ".vscode"

              # Application Local Share (Heavier Data)
              ".java"
              ".local/share/JetBrains"
              ".local/share/PrismLauncher"
              ".local/share/Steam"
              ".local/share/com.edde746.plezy"
              ".local/share/docker"
              ".local/share/flatpak"
              ".local/share/nvim"
              ".local/share/qalculate"
              ".vscode"
            ];
          };
        };
      };
    };
}
