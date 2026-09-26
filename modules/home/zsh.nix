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

# Only start an agent if we do not already have one. WezTerm provides its own
# agent (SSH_AUTH_SOCK is already set inside it), so this only kicks in for
# other terminals.
#
# SSH_ASKPASS_REQUIRE=never is scoped to this one command: your key is
# passphrase-protected, so without it every new shell pops an x11-ssh-askpass
# GUI dialog and blocks. Use `sa` below to add the key when you want it.
if [ -z "$SSH_AUTH_SOCK" ] && [ -f "$HOME/.ssh/id_ed25519" ]; then
  eval "$(ssh-agent -s)" >/dev/null
  SSH_ASKPASS_REQUIRE=never ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null || true
fi

# add the ssh key to the running agent (will prompt for the passphrase)
sa() { ssh-add "$HOME/.ssh/id_ed25519"; }

      ${lib.optionalString pkgs.stdenv.hostPlatform.isDarwin ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        if [ -x /usr/libexec/java_home ]; then
          JAVA_HOME=$(/usr/libexec/java_home -v 17 2>/dev/null) && export JAVA_HOME
        fi
        if [ -d "$HOME/Library/Android/sdk" ]; then
          export ANDROID_HOME=$HOME/Library/Android/sdk
          export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin
        fi
      ''}

      ${lib.optionalString pkgs.stdenv.hostPlatform.isLinux ''
        # java/android are not managed by nix here, so only export what exists
        if [ -d /usr/lib/jvm/java-21-openjdk-amd64 ]; then
          export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
        fi
        if [ -d "$HOME/Android/Sdk" ]; then
          export ANDROID_HOME=$HOME/Android/Sdk
          export PATH="$ANDROID_HOME/platform-tools:$PATH"
        fi
        alias pbcopy="xclip -sel clip"
      ''}

      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"


      eval "$(direnv hook zsh)"
    '';
  };
}
