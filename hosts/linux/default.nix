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

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT    = "en_IN";
    LC_MONETARY       = "en_IN";
    LC_NAME           = "en_IN";
    LC_NUMERIC        = "en_IN";
    LC_PAPER          = "en_IN";
    LC_TELEPHONE      = "en_IN";
    LC_TIME           = "en_IN";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable  = true;
    windowManager.i3 = {
      enable        = true;
      extraPackages = with pkgs; [
        i3status i3lock rofi feh picom xclip maim
        brightnessctl dunst xautolock libnotify
      ];
    };
  };

  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable   = true;

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  users.users.mikey = {
    isNormalUser    = true;
    shell           = pkgs.zsh;
    extraGroups     = [ "wheel" "networkmanager" "audio" "video" "bluetooth" ];
    initialPassword = "changeme";
  };

  environment.systemPackages = with pkgs; [ git curl wget nixd ];

  system.stateVersion = "24.11";
}
