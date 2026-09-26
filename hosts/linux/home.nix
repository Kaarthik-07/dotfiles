{ pkgs, ... }:
{
  imports = [
    ../../modules/home/zsh.nix
    ../../modules/home/git.nix
    ../../modules/home/neovim.nix
    ../../modules/home/wezterm.nix
    ../../modules/linux/i3.nix
  ];

  home = {
    username      = "mikey";
    homeDirectory = "/home/mikey";
    stateVersion  = "24.11";

    packages = with pkgs; [
      ripgrep fd fzf bat eza jq
      tmux direnv
      nodejs_22 go
      xclip feh xsetroot
      wezterm
      nerd-fonts.jetbrains-mono
      networkmanagerapplet
      brave
      pamixer
      copyq
      dmenu
      thunar
      thunar-volman
      thunar-archive-plugin
      gvfs
    ];
  };

  programs.home-manager.enable = true;
}
