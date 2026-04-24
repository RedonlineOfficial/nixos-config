{
  self,
  inputs,
  ...
}: {
  flake.homeModules.zshAliases = {...}: {
    programs.zsh.shellAliases = {
      # Nixos
      nixconf = "nvim ~/nixos-config";
      nixflake = "nix run .#write-flake";

      # Power
      shutdown = "sudo shutdown now";
      reboot = "sudo reboot";

      # Navigation
      ".." = "cd ..";
      "2." = "../../";
      "3." = "../../../";
      "4." = "../../../../";
      "5." = "../../../../../";

      # Files and Directories
      mkd = "mkdir -pv";
      cp = "cp -ir";
      mv = "mv -i";
      rm = "rm -ir";
      rmd = "rmdir -p";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      fd = "find . -type d -name";
      ff = "find . -type f -name";

      # Git
      gi = "git init";
      gic = "git init && git commit --allow-empty -m 'chore: init'";
      gs = "git status";
      gl = "git log --oneline --graph --decorate";
      ga = "git add";
      gaa = "git add --all";
      gau = "git restore --staged";
      gc = "git commit -v";
      gca = "git commit -v --amend";
      gac = "git add --all; git commit -v";
      gaca = "git add --all; git commit -v --amend";
      gco = "git checkout";
      gcm = "git checkout main";
      gp = "git push";
      gd = "git diff";
      gds = "git diff --staged";
      gpl = "git pull";
      gu = "git reset --soft HEAD~1";
      gcl = "git clone";

      # Neovim
      v = "nvim";
      sv = "sudo nvim";

      # LS Deluxe
      l = "lsd -A --group-directories-first";
      ll = "l -lh --header --git";
      lt = "l --tree -I \.git";
      llt = "lt -l";

      # Misc
      c = "clear";
      ":q" = "exit";
    };
  };
}
