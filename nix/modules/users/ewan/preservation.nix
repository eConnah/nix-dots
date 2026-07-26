{ self, ... }: {
  flake.nixosModules.ewan-preservation = { ... }: {
    imports = [
      self.nixosModules.preservation
    ];

    preservation.preserveAt."/persistent" = {
      # User-level persistence
      users.ewan = {
        directories = [
          # Core User State
          ".local/share/applications"
          ".local/share/fish"
          ".local/share/icons"
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
          ".config/Epic"
          ".config/JetBrains"
          ".config/Signal"
          ".config/easyeffects"
          ".config/libreoffice"
          ".config/mozilla"
          ".config/spotify"
          ".config/vesktop"
          ".config/vicinae"
          ".steam"

          # Application Local Share (Heavier Data)
          ".local/share/PrismLauncher"
          ".local/share/Steam"
          ".local/share/Terraria"
          ".local/share/com.edde746.plezy"
          ".local/share/docker"
          ".local/share/flatpak"
          ".local/share/nvim"
          ".local/share/qalculate"
          ".local/share/vicinae"
        ];
      };
    };
  };
}
