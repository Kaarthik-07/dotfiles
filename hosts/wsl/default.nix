{ pkgs, ... }:
{
  wsl = {
    enable        = true;
    defaultUser   = "mikey";
    startMenuLaunchers = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;

  users.users.mikey = {
    isNormalUser = true;
    shell        = pkgs.zsh;
    extraGroups  = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [ git curl wget wslu ];

  system.stateVersion = "24.11";
}
