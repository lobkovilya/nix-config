{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Go language server
    gopls
  ];
}
