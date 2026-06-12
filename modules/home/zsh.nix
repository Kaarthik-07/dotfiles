{ pkgs, lib, ... }:
{
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
