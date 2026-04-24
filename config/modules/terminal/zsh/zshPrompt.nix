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
          SYM_GIT_BRANCH=""
          SYM_GIT_STAGED=""
          SYM_GIT_UNSTAGED="󱈸"
          SYM_GIT_UNTRACKED=""
        fi

        # Git
        autoload -Uz vcs_info
        zstyle ':vcs_info:*' enable git
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:git:*' formats "%F{244}[ %F{cyan}''${SYM_GIT_BRANCH}%f %F{magenta}%b %F{244}]-[%f %m%u%c %F{244}]%f"
        zstyle ':vcs_info:*' stagedstr "%F{green}''${SYM_GIT_STAGED}%f"
        zstyle ':vcs_info:*' unstagedstr "%F{yellow}''${SYM_GIT_UNSTAGED}%f"
        zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

        +vi-git-untracked() {
          if git ls-files --others --exclude-standard | grep -q .; then
            hook_com[misc]+="%F{red}''${SYM_GIT_UNTRACKED}%f"
          fi
        }

        precmd() {
          local lastStatus=$?
          vcs_info

          local promptColor
          if [[ $lastStatus -eq 0 ]]; then
            promptColor="green"
          else
            promptColor="red"
          fi

          print -P "%F{blue}%~ ''${vcs_info_msg_0_}"
          PROMPT="%F{cyan}%n@%m%f %F{''${promptColor}''${SYM_PROMPT}%f "
        }
      '';
  };
}
