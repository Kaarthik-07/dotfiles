{ pkgs, ... }:
{
  imports = [
    ../../modules/darwin/system.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  # nix-darwin applies system.defaults (and homebrew) to this user only.
  # Without it, activation fails the primary-user assertion on recent pins.
  system.primaryUser = "mikey";

  # home-manager derives home.homeDirectory from this (its nixos/common.nix
  # sets `homeDirectory = config.users.users.<name>.home`), and home-manager
  # refuses a null homeDirectory -- so declare it explicitly.
  users.users.mikey.home = "/Users/mikey";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users         = [ "mikey" ];
  };

  programs.zsh.enable        = true;
  environment.systemPackages = with pkgs; [ git curl wget ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "aerospace"
      "wezterm"
    ];
  };

  system.stateVersion = 5;
}
