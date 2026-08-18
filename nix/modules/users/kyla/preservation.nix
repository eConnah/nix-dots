{ self, ... }: {
  flake.nixosModules.kyla-preservation = {
    imports = [
      self.nixosModules.preservation
    ];

    preservation.preserveAt."/persistent" = {
      users.kyla = {
        directories = [
          ".config/Epic"
          ".config/libreoffice"
          ".config/mozilla"
          ".config/obsidian"
          ".config/spotify"
          ".config/vicinae"
          ".local/share/PrismLauncher"
          ".local/share/Steam"
          ".local/share/Terraria"
          ".local/share/com.edde746.plezy"
          ".local/share/direnv"
          ".local/share/qalculate"
          ".local/share/vicinae"
          ".steam"
        ];
      };
    };
  };
}
