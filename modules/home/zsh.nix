{ pkgs, lib, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$python$nodejs$rust$golang$java\n$character";

      character = {
        success_symbol = "[❯](bold #89b4fa)";
        error_symbol   = "[❯](bold #f38ba8)";
      };

      directory = {
        style             = "bold #89b4fa";
        truncation_length = 3;
        truncate_to_repo  = true;
        read_only         = " ";
      };

      git_branch = {
        symbol = " ";
        style  = "bold #cba6f7";
        format = "[ $symbol$branch]($style)";
      };

      git_status = {
        style  = "bold #f38ba8";
        format = "([$all_status$ahead_behind]($style) )";
      };

      python = {
        symbol = " ";
        style  = "#f9e2af";
        format = "[ $symbol$version]($style)";
      };

      nodejs = {
        symbol = " ";
        style  = "#a6e3a1";
        format = "[ $symbol$version]($style)";
      };

      rust = {
        symbol = " ";
        style  = "#fab387";
        format = "[ $symbol$version]($style)";
      };

      golang = {
        symbol = " ";
        style  = "#89dceb";
        format = "[ $symbol$version]($style)";
      };

      java = {
        symbol = " ";
        style  = "#f38ba8";
        format = "[ $symbol$version]($style)";
      };
    };
  };

  programs.zsh = {
    enable                    = true;
    autosuggestion.enable     = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    history = {
      size       = 10000;
      ignoreDups = true;
      share      = true;
    };

    shellAliases = {
      v      = "nvim";
      c      = "clear";
      t      = "tmux";
      x      = "exit";
      doc    = "docker";
      sz     = "source ~/.zshrc";
      ll     = "ls -alF";
      la     = "ls -A";
      l      = "ls -CF";
      ls     = "eza";
      gac    = "git add . && git commit -m";
      please = "sudo";
      py     = "python3";
    };

    initContent = ''
export PATH="$HOME/.local/bin:$HOME/.claude/local:$PATH"
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
fi

      ${lib.optionalString pkgs.stdenv.isDarwin ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        export JAVA_HOME=$(/usr/libexec/java_home -v 17 2>/dev/null)
        export ANDROID_HOME=$HOME/Library/Android/sdk
        export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin
      ''}

      ${lib.optionalString pkgs.stdenv.isLinux ''
        export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
        export ANDROID_HOME=$HOME/Android/Sdk
        export PATH="$ANDROID_HOME/platform-tools:$PATH"
        alias pbcopy="xclip -sel clip"
      ''}

      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"


      eval "$(direnv hook zsh)"
    '';
  };
}
