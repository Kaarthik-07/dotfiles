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
      xclip feh polybar xorg.xsetroot
      wezterm
      nerd-fonts.jetbrains-mono
      networkmanagerapplet
      brave
      starship
      pamixer
      copyq
      dmenu
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      gvfs
    ];
  };

  programs.home-manager.enable = true;
}
