{ pkgs, ... }:
{
  imports = [
    ../../modules/home/zsh.nix
    ../../modules/home/git.nix
    ../../modules/home/neovim.nix
    ../../modules/home/wezterm.nix
  ];

  home = {
    username    = "mikey";
    homeDirectory = "/Users/mikey";
    stateVersion  = "24.11";

    packages = with pkgs; [
      ripgrep fd fzf bat eza jq
      tmux direnv
      nodejs_22 go
    ];
  };

  programs.home-manager.enable = true;
}
