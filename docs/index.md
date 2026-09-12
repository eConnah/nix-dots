+++
title = "Nix-Dots - Bonjour"
+++

<link rel="icon" type="image/svg+xml" href="assets/nix.svg">

# Bonjour

You must be here because you heard that...

::: {.tip}

nix fixes this

:::

and here is the documentation for the fix that I use.

## Style

I have a very minimal style no bars, no panels only the background and an app
launcher. All my hosts are themed with Catppuccin Mocha, oled variant but the
dots themselves support inserting different themes... in theory.

![app-launcher](https://assets.econnah.uk/nix/readme/app-launcher.png)
![fetch](https://assets.econnah.uk/nix/readme/fetch.png)

## Architecture

This is a "dendritic" flake: almost every file under `nix/` is a small,
self-contained module that attaches itself to the flake's output tree, rather
than being wired together by hand in `flake.nix`.

### import-tree

`flake.nix` only does one interesting thing:

```
outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./nix);
```

`import-tree` walks `nix/` and imports every `.nix` file it finds as a
flake-parts module. This means adding a new host, hjem module, or NixOS module
is usually just "add a new file" — nothing else needs to know it exists.

### One file, one concern

Host specific modules are generally named `<host>-config.nix`,
`<host>-hardware.nix`, `<host>-hjem.nix`, `<host>-disko.nix`, and combined in a
small `default.nix` that calls `nixpkgs.lib.nixosSystem`. Shared building blocks
(`defaults`, `hyprland`, `oledppuccin`, and so on) live in their own files and
are pulled in by name.

### Registries: hjemModules, nvfModules, secretModules

Three custom flake-parts options act as registries for reusable pieces:

- `flake.hjemModules` — reusable [hjem](https://github.com/feel-co/hjem) user
  configuration, tagged with `_class = "hjem"` so it can be `imports`-ed by name
  from any host's `hjem.users.<name>`.
- `flake.nvfModules` — reusable Neovim configuration, tagged `_class = "nvf"`,
  composed together in the `nvim-qwerty` package (see the NVF Modules page).
- `flake.secretModules` — optional, per-user `nix-secrets` declarations. See the
  Secrets page for why these are kept separate from the main `defaults` module.

Each registry is defined once, using `flake-parts-lib.mkSubmoduleOptions`, and
every other file just adds entries to it, e.g.
`flake.hjemModules.connor = { ... };`.

### Composing a host

A typical host file looks like:

```
flake.nixosConfigurations.<host> = inputs.nixpkgs.lib.nixosSystem {
  modules = with self.nixosModules; [
    defaults
    hyprland
    limine
    <host>-config
    <host>-hardware
    <host>-hjem
    # ...per-user modules (connor, kyla, aude, ewan, leo)...
  ];
```

## Secrets

Secrets are managed with
[nix-secrets](https://github.com/unnamed-systems/nix-secrets), an age-based
secrets module. Two things are worth understanding before touching it: recipient
aliases, and why secrets are split into per-user modules.

### Recipient aliases

`security.nix-secrets.recipientAliases` (set once, in `defaults`) maps a host
name to its age public key, plus an `all-hosts` alias covering every real
machine. Each secret declares which aliases can decrypt it via `recipients`,
e.g.:

```
security.nix-secrets.secrets."connor/linux" = {
  neededForUsers = true;
  recipients = ["ACE" "cookie" "lenix" "murtle" "onyx" "turtle" "yubikey"];
};
```

`hostRecipientAlias` (from the `secret-assertions` module) lets a host use a
different alias than its `networking.hostName`, though every current host uses
its own hostname.

### Why secrets are split per user

`nix-secrets` attempts to decrypt every secret declared for a host's evaluated
config, regardless of whether that host is actually a recipient — a host that
isn't listed still fails activation instead of just skipping the secret. To
avoid every host trying (and failing) to decrypt secrets for users it doesn't
have, each user's secrets live in their own `flake.secretModules.<user>` entry
(`connor`, `connor-eduroam`, `ewan`, `kyla`, `aude`), and only the NixOS modules
for hosts that actually have that user import the relevant one — e.g.
`self.secretModules.connor` is only imported by the `connor` NixOS module, which
in turn is only imported by hosts with a `connor` account.

`connor-eduroam` is a good example of splitting even further: it holds a single
secret (`connor/wifi/eduroam`) scoped to `lenix` and `yubikey` only, because no
other host needs eduroam credentials.

### secret-assertions

The `secret-assertions` module (flagged in its own source as AI-generated — read
it carefully before changing it) runs at evaluation time and fails the build,
rather than failing silently at activation, if:

- the host's recipient alias isn't present in `recipientAliases`, or
- any secret declared in that host's config lists recipients that don't include
  the host's alias (i.e. a secret that would fail to decrypt at runtime).

This turns a runtime activation failure into a build-time error, which is the
main reason to prefer importing scoped `secretModules` over adding secrets
directly to `defaults`.

### escapepod3 is the exception

`escapepod3` explicitly disables `nix-secrets`

## Building these docs

You can use the provided .envrc or manually enter the docs devshell with nix
develop. Run each of these commands in a seperate terminal:

```
darkhttpd build
watchexec --exts md,css,toml -- ndg html
```
