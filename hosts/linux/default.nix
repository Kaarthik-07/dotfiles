{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    systemd-boot.enable    = false;
    efi.canTouchEfiVariables = true;
    grub = {
      enable       = true;
      efiSupport   = true;
      device       = "nodev";
      useOSProber  = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName           = "nixos";
  networking.networkmanager.enable = true;

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
    isNormalUser    = true;
    shell           = pkgs.zsh;
    extraGroups     = [ "wheel" "networkmanager" "audio" "video" ];
    initialPassword = "changeme";  # set a real password after first login with: passwd
  };

  environment.systemPackages = with pkgs; [ git curl wget ];

  system.stateVersion = "24.11";
}
