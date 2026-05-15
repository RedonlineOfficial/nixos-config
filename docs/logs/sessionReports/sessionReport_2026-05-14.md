# Session Report — 2026-05-14 (Session 1)

**Session focus:** Bootstrap a new NixOS config from scratch using the Dendritic pattern with flake-parts, flake-file, and import-tree.

## What Got Done
- Created project structure: `CLAUDE.md`, `README.md`, `UNLICENSE`
- Wrote bootstrap `flake.nix` with all inputs; handed off to flake-file after verification
- Built module scaffold: `modules/hosts/`, `modules/users/`, `modules/features/`, `modules/suites/`, `modules/disks/`
- `modules/hosts/common/base.nix` — boot, locale, nix settings, home-manager hybrid setup, XDG dirs
- `modules/hosts/common/workstation/commonWorkstation.nix` — networkmanager, nix gc/optimise
- `modules/hosts/common/workstation/commonLaptop.nix` — nixos-hardware, thermald, auto-cpufreq
- `modules/users/joshua.nix` — NixOS user module, standalone homeConfiguration, homeModule
- `modules/hosts/hm-pc-ws-01/configuration.nix` — first host wired to nixosConfiguration output
- `modules/disks/efiSingleLuksExt4.nix` — disko layout with LUKS + ext4, generic `diskoOpts.device` option
- `modules/features/terminal/zsh/` — zsh, zshOptions, zshAliases, zshPrompt, zshFunctions
- `modules/features/terminal/lsd.nix`, `zoxide.nix`
- `modules/features/terminal/nvf/` — nvf with options, theme, keybinds, LSP, and plugins (blink-cmp, oil, telescope, treesitter, which-key)
- `modules/suites/terminal.nix` — suiteTerminal grouping zsh + lsd + zoxide + nvf
- All builds passing: `nixos-rebuild build --flake .#hm-pc-ws-01` succeeds
- Tagged releases: `v0.1.0` → `v0.2.0` → `v0.3.0` → `v0.4.0`

## Decisions Made
- Kernel: `pkgs.linuxPackages_latest` (tracking 7.0.x) — deferred switching to 7.0.6 until it lands in nixpkgs; SSH disabled so Dirty Frag (CVE-2026-43284/43500) local-only exploit is not a concern
- Home-manager: hybrid approach — runs standalone but exposed to NixOS so both `nixos-rebuild switch` and `home-manager switch` work
- `XDG_CACHE_HOME = "$HOME/.local/cache"` — intentionally non-standard; user wants to minimize home directory clutter
- `flake-file.flakeModules.dendritic` required (not `.default`) to expose `write-flake` app and keep `flake-file.*` options available post-generation
- `disko` input colocated in `base.nix` since all hosts use disko
- `auto-cpufreq` input colocated in `commonLaptop.nix`
- `nvf` input colocated in `nvf.nix`

## Open Items
- `nvf` not yet in `flake-file.inputs` — wait, this was resolved during session
- Remaining modules to build out: hyprland suite, waybar, other desktop features
- No server-side configs yet (`modules/hosts/common/server/` is empty)
- `modules/suites/` only has `terminal.nix` — more suites to come

## Context for Next Session
- Run `nix run ".#write-flake"` any time a new `flake-file.inputs` block is added to a module — then stage both `flake.nix` and `flake.lock` before committing
- `flake-file.flakeModules.dendritic` must always be in the flake outputs imports — it's in the `flake-file.outputs` template in `base.nix` so it survives regeneration
- The `_hardware-configuration.nix` prefix tells import-tree to ignore the file
- Branch naming: `feature/<name>`, merge with ff-only, tag on main after merge

## Handoff
**Status: Complete** — No additional work needed.
