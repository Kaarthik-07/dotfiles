{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true; # gives you the `nvidia-offload` command
      };
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:5:0:0";
    };
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.gamemode.enable = true;

  security.rtkit.enable = true; # pipewire wants this
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
        i3lock
        dmenu
        feh
        picom
        xclip
        maim
        brightnessctl
        dunst
        xautolock
        libnotify
      ];
    };
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  users.users.mikey = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "bluetooth"
      "docker"
    ];
    # PLACEHOLDER -- only used when the account is first created.
    # Change it immediately after the first boot with:  passwd mikey
    # Then delete this line and set `hashedPassword` (generate one with
    # `mkpasswd -m yescrypt`) so no plaintext secret lives in git.
    initialPassword = "changeme";
  };
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    nixd
  ];

  system.stateVersion = "24.11";
}
