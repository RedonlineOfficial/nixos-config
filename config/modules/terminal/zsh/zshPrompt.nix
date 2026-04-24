{
  self,
  inputs,
  ...
}: {
  flake.homeModules.zshPrompt = {...}: {
    programs.zsh.initContent =
      # bash
      ''
        # General Prompt Settings
        setopt prompt_subst

        # Symbols
        if [[ "$TERM" == linux ]]; then
          # Set symbols to plain characters if in a tty
          SYM_PROMPT=">"
          SYM_GIT_BRANCH="@"
          SYM_GIT_STAGED="*"
          SYM_GIT_UNSTAGED="!"
          SYM_GIT_UNTRACKED="?"
        else
          # Otherwise use nerd-font symbols
          SYM_PROMPT=" "
          SYM_GIT_BRANCH=" "
          SYM_GIT_STAGED=" "
          SYM_GIT_UNSTAGED=" "
          SYM_GIT_UNTRACKED=""
        fi

        # Git
        autoload -Uz vcs_info
        zstyle ':vcs_info:*' enable git
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:git:*' formats " ''${SYM_GIT_BRANCH}%b %m%u%c"
        zstyle ':vcs_info:*' stagedstr "''${SYM_GIT_STAGED}"
        zstyle ':vcs_info:*' unstagedstr "''${SYM_GIT_UNSTAGED}"
        zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

        +vi-git-untracked() {
          if git ls-files --others --exclude-standard | grep -q .; then
            hook_com[misc]+="''${SYM_GIT_UNTRACKED}"
          fi
        }

        precmd() {
          vcs_info

          print -P "%~ ''${vcs_info_msg_0_}"
          PROMPT="%n@%m ''${SYM_PROMPT} "
        }
      '';
  };
}
