{ self, inputs, ... }: {
  flake.homeModules.zshOptions = { config, ... }: {
    programs.zsh = {
      dotDir = "${config.xdg.configHome}/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        highlighters = [ "brackets" ];
      };
      setOptions = [
        "AUTO_CD"
        "CDABLE_VARS"
        "ALWAYS_TO_END"
        "AUTO_REMOVE_SLASH"
        "COMPLETE_ALIASES"
        "GLOB_COMPLETE"
        "HASH_LIST_ALL"
        "LIST_TYPES"
        "MENU_COMPLETE"
        "CASE_MATCH"
        "WARN_CREATE_GLOBAL"
        "APPEND_HISTORY"
        "EXTENDED_HISTORY"
        "HIST_EXPIRE_DUPS_FIRST"
        "HIST_FIND_NO_DUPS"
        "HIST_IGNORE_ALL_DUPS"
        "HIST_IGNORE_DUPS"
        "HIST_SAVE_NO_DUPS"
        "SHARE_HISTORY"
        "ALIASES"
        "CLOBBER"
        "CORRECT"
        "INTERACTIVE_COMMENTS"
        "PROMPT_SUBST"
      ];
    };
  };
}
