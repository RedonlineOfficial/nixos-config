{ self, inputs, ... }: {
  flake.homeModules.zshFunctions = {
    programs.zsh.initContent = # bash
      ''
        function rebuild-nix() {
          local confDir="''${1:-"$HOME/projects/nixos-config"}"
          local host="''${2:-$(hostname -s)}"
          sudo nixos-rebuild switch --flake $confDir#$host
        }

        function rebuild-home() {
          local confDir="''${1:-"$HOME/projects/nixos-config"}"
          local user="''${2:-$(whoami)}"
          home-manager switch -b backup --flake $confDir#$user
        }

        function nxsh() {
          nix shell nixpkgs#$1
        }

        function ext() {
          if [ $# -eq 0 ]; then
            echo "Usage: ext <file>"
            return 1
          fi

          local file="$1"

          if [ ! -f "$file" ]; then
            echo -e "ERR: File not found: '$file'"
            return 1
          fi

          case $file in
            *.tar.bz2|*.tbz2)   tar xjf   "$file";;
            *.tar.gz|*.tgz)     tar xzf   "$file";;
            *.tar.xz|*.txz)     tar xJf   "$file";;
            *.tar)              tar xf    "$file";;
            *.bz2)              bunzip2   "$file";;
            *.gz)               gunzip    "$file";;
            *.xz)               unxz      "$file";;
            *.zip)              unzip     "$file";;
            *.rar)              unrar x   "$file";;
            *.7z)               7z x      "$file";;
            *)
              echo "ERR: Unsupported file type: '$file'"
              return 1
              ;;

          esac
        }

        function mkcd() {
          local dir=$1
          mkdir -p -- "$dir"
          cd -- "$dir"
        }

        function gac() {
          git add "''${@:-.}" && git commit -v
        }

        function gaca() {
          git add "''${@:-.}" && git commit -v --amend
        }

        function where() {
          type -a $1
        }

        function gcf() {
          git checkout -b "feature/''${1}"
        }

        function gcfix() {
          git checkout -b "fix/''${1}"
        }
      '';
  };
}
