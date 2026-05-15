{ self, inputs, ... }: {
  flake.homeModules.zshAliases = { ... }: {
    programs.zsh.shellAliases = {

      nos = "rebuild-nix";
      hms = "rebuild-home";
      noc = "cd ~/nixos-config && nvim .";

      shutdown = "sudo shutdown now";
      reboot = "sudo reboot";

      cd = "z";
      ".." = "cd ..";
      "2." = "cd ../../";
      "3." = "cd ../../../";
      "4." = "cd ../../../../";
      "5." = "cd ../../../../../";

      mkd = "mkdir -pv";
      cp = "cp -ir";
      mv = "mv -i";
      rm = "rm -ir";
      rmd = "rmdir";
      grep = "rg";
      cat = "bat --paging=never";
      catp = "bat";

      gi = "git init";
      gic = "git init && git commit --allow-empty -m 'chore: init' && git tag -a v0.0.0 -m 'v0.0.0: Project init'";
      gs = "git status";
      gl = "git log --oneline --graph --decorate";
      ga = "git add";
      gc = "git commit -v";
      gca = "git commit -v --amend";
      gco = "git checkout";
      gcm = "git checkout main";
      gcb = "git checkout -b";
      gb = "git branch";
      gbd = "git branch -d";
      gp = "git push";
      gpt = "git push --tags";
      gppt = "git push && git push --tags";
      gt = "git tag";
      gsh = "git show";
      gd = "git diff";
      gds = "git diff --staged";
      gpl = "git pull";
      gcl = "git clone";

      v = "nvim";
      sv = "sudo nvim";

      l = "lsd -A --group-directories-first";
      ll = "l -lh --header --git";
      lt = "l --tree -I \.git";
      llt = "ll --tree -I \.git";

      c = "clear";
      ":q" = "exit";

      reload = "exec zsh";
      top = "btop";
      clive = "claude";
      ccc = "cd ~/projects/claude-config && nvim .";
    };
  };
}
