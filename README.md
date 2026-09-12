# nix-dots

A dendritic NixOS and Hjem flake managing my personal workstations and family
devices.

> **Read the full documentation at [nix.econnah.uk](https://nix.econnah.uk/)**

## Overview

This repository contains the configuration for my setup. It features a modular
design with Catppuccin themes, Hyprland, impermanence (ephemeral roots), and
age-based secrets management.

![app-launcher](https://assets.econnah.uk/nix/readme/app-launcher.png)
![fetch](https://assets.econnah.uk/nix/readme/fetch.png)

## Local Development

The documentation is built using `ndg`. A Nix development shell is provided to
easily work on the docs locally.

```bash
nix develop
darkhttpd build
watchexec --exts md,css,toml -- ndg html
```

## License

See [LICENSE](./LICENSE).
