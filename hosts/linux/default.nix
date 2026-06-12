{ pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable  = true;
    windowManager.i3 = {
      enable        = true;
      extraPackages = with pkgs; [ i3status rofi feh picom xclip ];
    };
  };

  programs.zsh.enable = true;

  users.users.mikey = {
    isNormalUser = true;
    shell        = pkgs.zsh;
    extraGroups  = [ "wheel" "networkmanager" "audio" "video" ];
  };

  environment.systemPackages = with pkgs; [ git curl wget ];

  system.stateVersion = "24.11";
}
