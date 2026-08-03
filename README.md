# nix-dots

My declarative NixOS + Home Manager configs for five machines across two
architectures. Built with the dendritic pattern via `flake-parts` +
`import-tree` every file just contributes to the flake, no central import list
to maintain.

This setup is highly opinionated toward how I want to run things. If you're
building your own, feel free to steal whatever's useful, but unless you agree
with all my opinions you probably will need to change a fair bit.

## Highlights

- **Five hosts, two architectures** — three `x86_64-linux` desktops and two
  `aarch64-linux` Apple Silicon laptops, sharing profiles cleanly across both
- **Ephemeral root** on Onyx, Nyx, Lenix, and Phoenix — tmpfs or wipe-on-boot
  roots, Disko-managed filesystems, opt-in state via
  [Preservation](https://github.com/nix-community/preservation)
- **Multi-user hosts** — Phoenix and Nyx are shared between Connor and Ewan,
  each with their own home-manager profile and preservation rules
- **Stylix + Catppuccin** theming, driven declaratively across every app
- **Hyprland**, launched through UWSM, with Hyprpanel and Vicinae
- **Fully declarative Neovim** via [nvf](https://github.com/notashelf/nvf)
- **Lix** on main running on all hosts.
- **Custom packages** (e.g. the
  [Robrix](https://github.com/project-robius/robrix) Matrix client) built and
  exposed via `perSystem.packages`

## Hosts

| Host           | Owner(s)     | Device                  | Notable bits                                                                                            |
| -------------- | ------------ | ----------------------- | ------------------------------------------------------------------------------------------------------- |
| **onyx**       | Connor       | Desktop (x86_64)        | Nvidia, gaming (Steam/Proton/Gamescope), custom PipeWire quantum, ephemeral (tmpfs) root, Disko         |
| **nyx**        | Connor, Ewan | Desktop (x86_64)        | Nvidia, gaming, OBS w/ CUDA + DaVinci Resolve, secondary XFS data disk, ephemeral (tmpfs) root          |
| **phoenix**    | Connor, Ewan | Desktop (x86_64)        | Mesa/integrated graphics, F2FS root wiped on every boot via a Disko + systemd unit, secondary data disk |
| **lenix**      | Connor       | MacBook (Apple Silicon) | Asahi, ephemeral (tmpfs) root, zswap                                                                    |
| **escapepod3** | Leo          | MacBook (Apple Silicon) | Asahi, traditional (non-ephemeral) Btrfs root                                                           |

## Users

| User   | Hosts                     |
| ------ | ------------------------- |
| Connor | onyx, nyx, phoenix, lenix |
| Ewan   | nyx, phoenix              |
| Leo    | escapepod3                |

Each user has their own NixOS module (account, groups, preservation rules) and
home-manager module (packages, dotfiles, per-host overrides like Hyprland config
and wallpaper).

## Structure

```bash
nix/
├── flake/            # flake-parts stuff (home-manager wiring, systems, treefmt/pedantix, nvfModules option)
├── hosts/            # per-machine configs — hardware, disks, host-specific home-manager
├── modules/
│   ├── bootloaders/  # Limine, shared bootloader defaults
│   ├── desktops/     # Hyprland — getting other WMs to work may or may not be a challenge
│   ├── packages/     # custom derivations (Robrix, robius-packaging-commands)
│   ├── presets/      # per-app configs (audio profiles, etc.)
│   ├── profiles/     # shared system logic — nvidia, mesa, asahi, laptops, lix, preservation
│   ├── programs/     # per-app modules (vicinae, hyprpanel, lix)
│   ├── services/     # user services (swaybg)
│   ├── themes/       # Stylix + Catppuccin
│   └── users/        # per-user NixOS + home-manager + preservation rules
└── nvim/             # nvf-based Neovim config
```

## Key technologies

NixOS · Home Manager · Disko · Preservation · Limine · Hyprland (UWSM) · Stylix
· Catppuccin · nvf · Vicinae · Lix

## License

See [LICENSE](./LICENSE).
