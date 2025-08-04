{ config, lib, pkgs, inputs, ... }:
{
  home.username = lib.mkDefault "ilya";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    cowsay
    nerd-fonts.jetbrains-mono
    hyprpaper
  ];

  home.file = {
    # LazyVim configuration
    ".config/nvim/init.lua".source = ./dotfiles/nvim/init.lua;
    ".config/nvim/.neoconf.json".source = ./dotfiles/nvim/.neoconf.json;
    ".config/nvim/lazyvim.json".source = ./dotfiles/nvim/lazyvim.json;
    ".config/nvim/stylua.toml".source = ./dotfiles/nvim/stylua.toml;
    ".config/nvim/lua".source = ./dotfiles/nvim/lua;

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.waybar.enable = true;

  # ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;
    initContent = ''
      if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland
      fi
    '';
  };

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
