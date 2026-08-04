{ self, ... }: {
  flake.nixosModules.connor-preservation = { ... }: {
    imports = [
      self.nixosModules.preservation
    ];

    preservation.preserveAt."/persistent" = {
      # User-level persistence
      users.connor = {
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
          ".config/halloy"
          ".config/lazyspotify"
          ".config/libreoffice"
          ".config/mozilla"
          ".config/obs-studio"
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
          ".local/share/Terraria"
          ".local/share/com.edde746.plezy"
          ".local/share/direnv"
          ".local/share/docker"
          ".local/share/flatpak"
          ".local/share/nvim"
          ".local/share/qalculate"
          ".local/share/robrix"
          ".local/share/vicinae"
          ".vscode"
        ];
      };
    };
  };
}
