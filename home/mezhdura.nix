{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./modules/starship.nix
    ./modules/zsh-starship.nix
    ./modules/nvim.nix
    ./modules/zsh.nix
  ];

  home.username = lib.mkDefault "lobkovilya";
  home.homeDirectory = lib.mkDefault "/Users/${config.home.username}";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    cowsay
    nerd-fonts.jetbrains-mono
  ];

  home.file = {
    # Ghostty
    ".config/ghostty".source = ./dotfiles/ghostty;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
  programs.lazygit.enable = true;

  fonts.fontconfig.enable = true;
}
