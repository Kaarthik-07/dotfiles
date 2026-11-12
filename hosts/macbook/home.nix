{ pkgs, ... }:
{
  imports = [
    ../../modules/home/zsh.nix
    ../../modules/home/git.nix
    ../../modules/home/neovim.nix
    ../../modules/home/wezterm.nix
    # aerospace.nix writes xdg.configFile, a home-manager option -- it used to
    # be imported by hosts/macbook/default.nix (nix-darwin), where `xdg` does
    # not exist and the whole darwin build failed to evaluate.
    ../../modules/darwin/aerospace.nix
  ];

  home = {
    username    = "mikey";
    homeDirectory = "/Users/mikey";
    stateVersion  = "24.11";

    # screencapture.location (modules/darwin/system.nix) points here, and
    # macOS silently drops captures if the directory does not exist yet.
    file."Pictures/Screenshots/.keep".text = "";

    packages = with pkgs; [
      ripgrep fd fzf bat eza jq
      tmux direnv
      nodejs_22 go
      nerd-fonts.jetbrains-mono
    ];
  };

  programs.home-manager.enable = true;
}
