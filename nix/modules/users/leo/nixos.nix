{ self, ... }: {
  flake.nixosModules.leo = { pkgs, ... }: {
    hjem = {
      users.leo = {
        imports = with self.hjemModules; [ leo ];
        enable = true;
        directory = "/home/leo";
        user = "leo";
      };
    };
    users = {
      groups.leo = {
        gid = 2006;
      };

      users.leo = {
        description = "Leo Chittock";
        extraGroups = [
          "wheel"
          "networkmanager"
          "dialout"
          "uucp"
        ];
        group = "leo";
        isNormalUser = true;
        shell = pkgs.fish;
        uid = 2006;
      };
    };
  };
}
