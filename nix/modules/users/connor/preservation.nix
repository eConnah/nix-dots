{ self, ... }: {
  flake.nixosModules.connor-preservation = {
    imports = [
      self.nixosModules.preservation
    ];

    preservation.preserveAt."/persistent" = {
      # User-level persistence
      users.connor = {
        directories = [
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
          ".local/share/qalculate"
          ".local/share/robrix"
          ".local/share/vicinae"
          ".vscode"
        ];
      };
    };
  };
}
