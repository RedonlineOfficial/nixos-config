# Session Issues — 2026-05-14 (Session 1)

## Issues Found

### 1. [Repeated Error] flake-file module not imported in generated flake
- **Severity:** high
- **Occurrences:** 2
- **Context:** After `nix run ".#write-flake"` generates a new `flake.nix`, the generated file does not include `inputs.flake-file.flakeModules.dendritic` in its imports. This means any module using `flake-file.inputs` or `flake-file.outputs` options fails with `The option 'flake-file' does not exist`. Occurred first after the initial flake generation, then again after adding `joshua.nix`.
- **What was tried:** Running `nix flake show` and `nixos-rebuild build` which both failed with the same error.
- **What worked:** Adding `inputs.flake-file.flakeModules.dendritic` to both the bootstrap `flake.nix` imports AND the `flake-file.outputs` template string in `base.nix`, so it persists into all future generated flakes.

### 2. [Missing Guidance] flake-file requires `.dendritic` module, not `.default`, to expose `write-flake`
- **Severity:** medium
- **Occurrences:** 1
- **Context:** `nix run ".#write-flake"` failed with `does not provide attribute 'apps.x86_64-linux.write-flake'`. The bootstrap flake was importing `inputs.flake-file.flakeModules.default`, which doesn't include `systems.nix`. Without `systems`, flake-parts can't generate per-system outputs so `write-flake` is never exposed. Required reading the flake-file source in `/nix/store` to diagnose.
- **What was tried:** Searched docs, fetched flake-file docs page (unhelpful), eventually found the source at `/nix/store/*-source/modules/dendritic/` which revealed `systems.nix` sets `systems = lib.mkDefault lib.systems.flakeExposed`.
- **What worked:** Changing the import to `inputs.flake-file.flakeModules.dendritic`.

### 3. [Repeated Error] Copy-paste input URL errors
- **Severity:** low
- **Occurrences:** 2
- **Context:** Twice during the session, a `flake-file.inputs` block was given the wrong URL by copying from an adjacent input: (1) `flake-file.url = "https://github.com/denful/flake-file"` — should be `github:` scheme; (2) `disko.url = "github:nix-community/home-manager"` — wrong repo URL copy-pasted from the home-manager input above it.
- **What was tried:** First caught during review before building. Second caught during review.
- **What worked:** Manual correction each time.

### 4. [Compliance Failure] `nix-hardware` naming inconsistency across files
- **Severity:** medium
- **Occurrences:** 2
- **Context:** The bootstrap `flake.nix` used `nix-hardware` as the input name, but `base.nix` used `nixos-hardware`. Modules referencing `inputs.nixos-hardware` failed to find the input. The correct name is `nixos-hardware` (matching the GitHub repo `NixOS/nixos-hardware`).
- **What was tried:** Caught during file review.
- **What worked:** Renaming the input in `flake.nix` to `nixos-hardware`.

### 5. [Missing Guidance] Trailing slash in `.gitignore` doesn't match symlinks
- **Severity:** low
- **Occurrences:** 1
- **Context:** `result/` in `.gitignore` only matches directories. The `nixos-rebuild build` result is a symlink, so `result/` didn't ignore it. Required a fix commit after the initial commit.
- **What was tried:** Initial commit used `result/`.
- **What worked:** Changed to `result` (no trailing slash).

### 6. [Missing Guidance] `flake.lock` not committed before branch merge
- **Severity:** low
- **Occurrences:** 1
- **Context:** Before merging `feature/nvf`, the flake.lock had been updated by `nix run ".#write-flake"` but not committed. `git rebase` failed with `cannot rebase: You have unstaged changes`.
- **What was tried:** Attempted rebase directly.
- **What worked:** Staged and committed `flake.lock` as a `chore:` commit before proceeding with the merge.

### 7. [Knowledge Gap] Outdated knowledge of NixOS stable release
- **Severity:** low
- **Occurrences:** 1
- **Context:** Incorrectly identified NixOS stable as `24.11`. User corrected: current stable is `25.11`, with `26.05` in beta as of May 2026. Memory saved.
- **What was tried:** Stated 24.11 as current stable.
- **What worked:** User correction; memory updated.

## Determinism Candidates
- After `nix run ".#write-flake"`, always stage and commit `flake.nix` and `flake.lock` together before any other git operations — could be a pre-commit hook or documented checklist step.
- Before merging a feature branch, check for unstaged `flake.lock` changes.
