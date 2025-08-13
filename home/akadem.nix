{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.walker.homeManagerModules.default
    ./modules/starship.nix
    ./modules/zsh-starship.nix
    ./modules/nvim.nix
    ./modules/zsh.nix
    ./modules/zsh-hyprland.nix
  ];

  home.username = lib.mkDefault "ilya";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    cowsay
    nerd-fonts.jetbrains-mono
    hyprpaper
  ];

  home.file = {
    # Hyprland
    ".config/hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;

    # Hyprpaper
    ".config/hyprpaper".source = ./dotfiles/hyprpaper;

    # Waybar
    ".config/waybar".source = ./dotfiles/waybar;

    # Ghostty
    ".config/ghostty".source = ./dotfiles/ghostty;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
  programs.waybar.enable = true;
  programs.walker.enable = true;
  programs.lazygit.enable = true;
  programs.fzf.enable = true;
  programs.mise.enable = true;
  programs.go.enable = true;
  programs.jq.enable =true;

  fonts.fontconfig.enable = true;

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        ".config/hyprpaper/wp/watchtower-mountains-and-forests.jpg"
      ];
      wallpaper = [
        ",.config/hyprpaper/wp/watchtower-mountains-and-forests.jpg"
      ];
    };
  };
}
