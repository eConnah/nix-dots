# NixOS System Configurations

This repository contains my declarative NixOS and Home Manager configurations.
It is structured using a dendritic architecture, which strictly separates
hardware-agnostic defaults and user profiles from host-specific hardware
configurations.

## Repository Structure

The configuration uses `import-tree` to automatically evaluate modules within
the `nix/` directory.

- `flake.nix`: The primary entry point defining inputs (nixpkgs, disko,
  preservation, home-manager, nvf, stylix, etc.) and outputs.
- `nix/hosts/`: Machine-specific configurations.
  - `onyx`: Connor's desktop PC configuration.
  - `lenix`: Connor's Apple Silicon laptop configuration.
  - `escapepod3`: Leo's Apple Silicon laptop configuration.
- `nix/modules/`: Reusable components and logic.
  - `bootloaders/`: Bootloader configuration, primarily using Limine.
  - `desktops/`: Window manager configurations (Hyprland).
  - `presets/`: Application-specific configurations and audio profiles (e.g.,
    EasyEffects).
  - `profiles/`: Shared system configurations, package sets, and specific
    hardware logic (e.g., Asahi, Nvidia).
  - `programs/`: Application-specific settings (e.g., Vicinae, Hyprpanel).
  - `services/`: User service configurations (e.g., swaybg).
  - `themes/`: System-wide colour theme integrations using Stylix and
    Catppuccin.
  - `users/`: User-specific data, Home Manager integrations, and state
    preservation rules.
- `nix/nvim/`: Modular and declarative Neovim configuration built with NVF.

## Host Configurations

### Onyx (Desktop)

Connor's primary desktop environment configured for gaming and general use.

- **Filesystem:** Declarative Btrfs disk layout managed by Disko, featuring an
  ephemeral root on tmpfs (`/`).
- **State Management:** Opt-in persistence managed by Preservation. System and
  user data are routed to a persistent NVMe subvolume.
- **Hardware:** Nvidia proprietary drivers with modesetting.
- **Networking:** Minimal systemd-networkd configuration, with Tailscale for
  secure network access.
- **Audio:** Custom PipeWire quantum configurations.

### Lenix (Laptop)

Connor's laptop configuration tailored for Apple Silicon hardware.

- **Hardware Integration:** Utilises the `apple-silicon-support` flake for
  hardware compatibility.
- **Filesystem & State:** Ephemeral root on tmpfs (`/`) with opt-in state
  persistence, mirroring the desktop architecture.
- **Memory:** zswap with lz4 compression and x86_64 emulation via binfmt.
- **Power Management:** iio-hyprland for auto-rotation, with NetworkManager and
  iwd handling connectivity.

### Escapepod3 (Laptop)

Leo's laptop configuration, also targeting Apple Silicon hardware.

- **Hardware Integration:** Utilises the `apple-silicon-support` flake, sharing
  the Asahi profile with Lenix.
- **Filesystem:** Standard Btrfs root filesystem.
- **Memory:** zswap with lz4 compression and x86_64 emulation via binfmt.
- **Power Management:** iio-hyprland for auto-rotation.

## Key Technologies

- **NixOS & Flakes:** System configuration and dependency management.
- **Home Manager:** User environment and dotfile management.
- **Disko:** Declarative disk partitioning and formatting.
- **Preservation:** Opt-in state management for ephemeral root filesystems.
- **Limine:** Modern and minimal bootloader.
- **Hyprland:** Wayland compositor managed via UWSM.
- **Stylix & Catppuccin:** Declarative system-wide colour theme integration.
- **NVF:** Modular Neovim configuration.
- **Vicinae:** Application launcher.
