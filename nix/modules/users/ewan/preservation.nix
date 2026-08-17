{ self, ... }: {
  flake.nixosModules.ewan-preservation = {
    imports = [
      self.nixosModules.preservation
    ];

    preservation.preserveAt."/persistent" = {
      users.ewan = {
        directories = [
          ".config/Code"
          ".config/Epic"
          ".config/libreoffice"
          ".config/mozilla"
          ".config/spotify"
          ".config/vicinae"
          ".java"
          ".local/share/PrismLauncher"
          ".local/share/Steam"
          ".local/share/Terraria"
          ".local/share/com.edde746.plezy"
          ".local/share/direnv"
          ".local/share/qalculate"
          ".local/share/robrix"
          ".local/share/vicinae"
          ".steam"
          ".vscode"
        ];
      };
    };
  };
}
