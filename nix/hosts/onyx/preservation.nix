{ self, ... }: {
  flake.nixosModules.onyxPreservation = { ... }: {
    imports = [
      self.nixosModules.connorPreservation
    ];

    preservation.preserveAt."/persistent" = {
      # User-level persistence
      users.connor = {
        directories = [
        ];
      };
    };
  };
}
