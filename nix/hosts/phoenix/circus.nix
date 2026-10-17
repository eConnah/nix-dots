{inputs, ...}: {
  flake.nixosModules.phoenix-circus = {config, ...}: {
    imports = [inputs.circus.nixosModules.default];
    services.circus = {
      enable = true;
      server.enable = true;
      evaluator.enable = true;
      queueRunner.enable = true;

      settings = {
        database.url = "postgresql:///circus?host=/run/postgresql&user=circus";
        cache = {
          enabled = true;
          cache_url = "https://circus.ts.econnah.uk/nix-cache";
        };
        declarative = {
          users = [
            {
              username = "admin";
              email = "git@econnah.uk";
              password_file = config.security.nix-secrets.secrets."other/circus/admin-password".path;
              role = "admin";
            }
          ];
          api_keys = [
            {
              name = "admin-key";
              key_file = config.security.nix-secrets.secrets."other/circus/admin-key".path;
              role = "admin";
            }
          ];
        };
        server = {
          host = "100.110.83.57";
          port = 3000;
          force_secure_cookies = true;
        };
        queue_runner.workers = 2;
        evaluator = {
          poll_interval = 300;
          restrict_eval = false;
        };
        signing = {
          enabled = true;
          key_file = config.security.nix-secrets.secrets."nix-cache-key".path;
          public_key = "lecache:T6owlM58CGYc8X5xrAMq+IP6ilNWBpWlR8VazPPkjAQ=";
        };
      };
    };
    system.nixos-core.persistence.stores."/persistent".directories = [
      "/var/lib/circus"
      "/var/lib/postgresql"
    ];
    security.nix-secrets.secrets = {
      "other/circus/admin-password" = {
        group = "circus";
        owner = "circus";
        recipients = ["phoenix" "yubikey"];
      };
      "other/circus/admin-key" = {
        group = "circus";
        owner = "circus";
        recipients = ["phoenix" "yubikey"];
      };
      "nix-cache-key" = {
        group = "circus";
        owner = "circus";
      };
    };
  };
}
