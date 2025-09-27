{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./modules/starship.nix
    ./modules/zsh-starship.nix
    ./modules/nvim.nix
    ./modules/zsh.nix
  ];

  home.username = lib.mkDefault "ilya.lobkov@konghq.com";
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

  home.sessionPath = [
    "$HOME/go/src/github.com/kumahq/kuma/build/artifacts-darwin-arm64/kumactl"
    "$HOME/go/src/github.com/kumahq/kuma/build/artifacts-darwin-arm64/kuma-cp"
    "$HOME/go/src/github.com/kumahq/kuma/build/artifacts-darwin-arm64/kuma-dp"
  ];

  programs.home-manager.enable = true;
  programs.lazygit.enable = true;
  programs.fzf.enable = true;

  fonts.fontconfig.enable = true;
}
