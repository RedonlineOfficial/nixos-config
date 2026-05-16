# Session Issues — 2026-05-15 (Session 1)

## Issues Found

### 1. [Workaround] Git rebase failed due to unstaged changes on feature branch

- **Severity:** low
- **Occurrences:** 1
- **Context:** While merging `feature/terminal-utils` into `main`, two files
  (`zshAliases.nix`, `zshFunctions.nix`) were intentionally destined for direct
  commits to `main` rather than the feature branch. When `git rebase main` was
  run on the feature branch, git refused with: `error: cannot rebase: You have
  unstaged changes.` The files hadn't been staged or stashed.
- **What was tried:** Ran `git rebase main` directly with unstaged changes present.
- **What worked:** `git stash` before rebase, completed the rebase + ff-only
  merge + tag, then `git stash pop` and committed the zsh files directly to main.

## Determinism Candidates
- When a workflow involves committing some files to a feature branch and others
  directly to main, stash the "direct-to-main" files before opening the feature
  branch, or stage them explicitly before any rebase step.
