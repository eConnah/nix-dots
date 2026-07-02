# nix-dots

My declarative NixOS + Home Manager configs for three machines across two
architectures. Built with the dendritic pattern via `flake-parts` +
`import-tree` every file just contributes to the flake, no central import list
to maintain.

This setup is highly opinionated toward how I want to run things. If you're
building your own, feel free to steal whatever's useful, but unless you agree
with all my opinions you probably will need to change a fair bit.

## Highlights

- **Three hosts, two architectures** — `x86_64-linux` desktop + two
  `aarch64-linux` Apple Silicon laptops, sharing profiles cleanly across both
- **Ephemeral root** on Onyx and Lenix — tmpfs `/`, Disko-managed Btrfs, opt-in
  state via [Preservation](https://github.com/nix-community/preservation)
- **Stylix + Catppuccin** theming, driven declaratively across every app
- **Hyprland**, launched through UWSM, with Hyprpanel and Vicinae
- **Fully declarative Neovim** via [nvf](https://github.com/notashelf/nvf)

## Hosts

| Host           | Owner  | Device                  | Notable bits                                                                     |
| -------------- | ------ | ----------------------- | -------------------------------------------------------------------------------- |
| **onyx**       | Connor | Desktop (x86_64)        | Nvidia, gaming (Steam/Proton/Gamescope), custom PipeWire quantum, ephemeral root |
| **lenix**      | Connor | MacBook (Apple Silicon) | Asahi, ephemeral root, zswap                                                     |
| **escapepod3** | Leo    | MacBook (Apple Silicon) | Asahi, traditional (non-ephemeral) root                                          |

## Structure

```bash
nix/
├── flake/            # flake-parts stuff (home-manager, nvf wiring)
├── hosts/            # per-machine configs — hardware, disks, host-specific home-manager
├── modules/
│   ├── bootloaders/  # only Limine but probably easy to expand
│   ├── desktops/     # Hyprland getting other ones to work may or may not be a challenge.
│   ├── presets/      # per-app configs (audio profiles, etc.)
│   ├── profiles/     # shared system logic — nvidia, asahi, laptops, preservation
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
