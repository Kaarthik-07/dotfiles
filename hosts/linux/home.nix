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
      xclip rofi feh polybar xorg.xsetroot
      wezterm
      nerd-fonts.jetbrains-mono
      networkmanagerapplet
      brave
    ];
  };

  programs.home-manager.enable = true;
}
