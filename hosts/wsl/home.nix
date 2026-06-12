{ pkgs, ... }:
{
  imports = [
    ../../modules/home/zsh.nix
    ../../modules/home/git.nix
    ../../modules/home/neovim.nix
    # no wezterm — running Windows-side wezterm connecting to WSL
  ];

  home = {
    username      = "mikey";
    homeDirectory = "/home/mikey";
    stateVersion  = "24.11";

    packages = with pkgs; [
      ripgrep fd fzf bat eza jq
      tmux direnv
      nodejs_22 go
    ];
  };

  programs.home-manager.enable = true;
}
