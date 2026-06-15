{ self, ... }: {
  flake.nixosModules.lenixPreservation = { ... }: {
    imports = [
      self.nixosModules.connorPreservation
    ];

    preservation.preserveAt."/persistent" = {
      # System-level persistence
      directories = [
        "/etc/NetworkManager"
        "/etc/iwd"
        "/var/lib/bluetooth"
        "/var/lib/iwd"
      ];

      users.connor = {
        directories = [
        ];
      };
    };
  };
}
