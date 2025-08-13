{ config, pkgs, inputs, outputs, ... }:
let
  llm = { lib, ... }: {
    nixpkgs.config.rocmSupport = true;
    environment.systemPackages = with pkgs; [
      btop-rocm
      rocmPackages.rocminfo
      rocmPackages.rocm-smi
      rocmPackages.clr.icd
      ollama
    ];
    users.users.ilya.extraGroups = lib.mkAfter [ "video" "render" ];
    hardware.amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
    };
  };
  gaming = {
    environment.systemPackages = with pkgs; [
      mangohud
      protonup
    ];
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/ilya/.steam/root/compatibilitytools.d";
    };
    hardware.opengl = {
      enable = true;
      driSupport32Bit = true;
    };
    hardware.enableRedistributableFirmware = true;
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = ["amdgpu"];
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
  };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      llm
      gaming
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "akadem"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ilya = {
    isNormalUser = true;
    description = "ilya";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "ilya";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim
    git
    gcc
    btop
    ghostty
    firefox
  ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    users.ilya = import ../../home/${config.networking.hostName}.nix;
    backupFileExtension = "backup";
  };

  services.tailscale.enable = true;
  programs.hyprland.enable = true;
  programs.zsh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
