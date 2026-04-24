{
  self,
  inputs,
  ...
}: {
  flake.homeModules.zshOptions = {...}: {
    programs.zsh = {
      autocd = true;
      enableCompletion = true;
      autosuggestion.enable = true;

      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
        ];
      };

      history = {
        append = true;
        share = true;
        extended = true;
        expireDuplicatesFirst = true;
        findNoDups = true;
        ignoreAllDups = true;
        ignoreDups = true;
        saveNoDups = true;
        save = 10000;
      };

      historySubstringSearch.enable = true;
    };
  };
}
