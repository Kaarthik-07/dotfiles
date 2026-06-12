{ pkgs, ... }:
{
  imports = [
    ../../modules/darwin/system.nix
    ../../modules/darwin/aerospace.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

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
