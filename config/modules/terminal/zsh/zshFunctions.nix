{
  self,
  inputs,
  ...
}: {
  flake.homeModules.zshFunctions = {...}: {
    programs.zsh.initContent =
      # bash
      ''
        # Rebuild nixos config
        function rebuild-nix() {
          local confDir="''${1:-"$HOME/nixos-config"}"
          local host="''${2:-$(hostname -s)}"

          sudo nixos-rebuild switch --flake $confDir#$host
        }

        # Rebuild home-manager config
        function rebuild-home() {
          local confDir="''${1:-"$HOME/nixos-config"}"
          local user="''${2:-$(whoami)}"

          home-manager switch --flake $confDir#$user
        }

        # Universal* file extractor
        function extract() {
          if [ $# -eq 0 ]; then
            echo "Usage: extract <file>"
            return 1
          fi

          local file="$1"
          if [ ! -f "$file" ]; then
            echo -e "ERR: File not found: '$file'"
            return 1
          fi

          case "$file" in
            *.tar.bz2|*.tbz2)   tar xjf "$file";;
            *.tar.gz|*.tgz)     tar xzf "$file";;
            *.tar.xz|*.txz)     tar xJf "$file";;
            *.tar)              tar xf "$file";;
            *.bz2)              bunzip2 "$file";;
            *.gz)               gunzip "$file";;
            *.xz)               unxz "$file";;
            *.zip)              unzip "$file";;
            *.rar)              unrar x "$file";;
            *.7z)               7z x "$file";;
            *)
              echo "ERR: Unsupported file type '$file'"
              return 1
              ;;
          esac
        }

        # Create a temporary neovim "scratchpad"
        function sp() {
          nvim $(mktemp /tmp/scratchpad.XXXXXX)
        }

        # Create a temporary script and optionally execute it
        function script() {
          local execute=false
          while getopts ":e" opt; do
            case $opt in
              e) execute=true;;
              *)
                echo -e "Usage: script [ -e ]"
                echo -e "   -e : execute script when closing"
                return 1
                ;;
            esac
          done

          local tmpScript=$(mktemp /tmp/script.XXXXXX)
          echo '#!/usr/bin/env bash' > "$tmpScript"
          nvim "$tmpScript"
          if [ $? -eq 0 ]; then
            chmod +x "$tmpScript"
            echo -e "Created executable script at: $tmpScript"
          else
            echo -e "ERR: Neovim exited with errors. File left at $tmpScript"
            return 1
          fi

          if [[ "$execute" == true ]]; then
            "$tmpScript"
          fi
        }

        # Mkdir and cd into it
        function mcd() {
          if [[ $# -eq 0 ]]; then
            echo "Usage: mcd <path/to/dir>"
            return 1
          fi

          local dir="$1"
          mkdir -p -- "$dir"
          cd -- "$dir"
        }

        # Use oil.nvim's ssh ability to ssh into a remote file or directory
        function oil() {
          if [[ $# -eq 0 ]]; then
            echo "Usage: oil <user>@<host>[:<port>] <remote-path>"
            return 1
          fi

          local userHost=$1
          local remotePath=$2
          if [[ $userHost =~ :([0-9]+)$ ]]; then
            local port="''${match[1]}"
            userHost=''${userHost%%:*}
          fi

          local cmd="oil-ssh://''${userHost}:''${port}/''${remotePath}"
          nvim "$cmd"
        }
      '';
  };
}
