{ self, inputs, ... }: {
  flake.homeModules.zshPrompt = { ... }: {
    programs.zsh.initContent = # zsh
    ''
      if [ $TERM = "linux" ]; then
        PROMPT_SYM=">"
        GIT_BRANCH_SYM="@"
        GIT_STAGED_SYM="*"
        GIT_UNSTAGED_SYM="!"
        GIT_UNTRACKED_SYM="?"
      else
        # TODO: Change out symbols to nerd fonts
        PROMPT_SYM=">"
        GIT_BRANCH_SYM="@"
        GIT_STAGED_SYM="*"
        GIT_UNSTAGED_SYM="!"
        GIT_UNTRACKED_SYM="?"
      fi

      autoload -Uz vcs_info
      zstyle ':vcs_info:*' enable git
      zstyle ':vcs_info:git:*' formats '%F{cyan}''${GIT_BRANCH_SYM} %b%f %m%u%c'
      zstyle ':vcs_info:*' check-for-changes true
      zstyle ':vcs_info:*' stagedstr '%F{green}''${GIT_STAGED_SYM}%f'
      zstyle ':vcs_info:*' unstagedstr '%F{red}''${GIT_UNSTAGED_SYM}%f'
      zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

      +vi-git-untracked() {
        if git ls-files --others --exclude-standard | grep -q .; then
          hook_com[misc]+='%F{yellow}''${GIT_UNTRACKED_SYM}%f'
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

        print -P "%F{magenta}%~%f ''${vcs_info_msg_0_}"
        PROMPT="%F{cyan}%n@%m%f %F{''${promptColor}}''${PROMPT_SYM} %f"
      }
    ''; 
  };
}
