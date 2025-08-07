{ pkgs, ... }:
{
  home.packages = with pkgs; [
    starship
  ];

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      line_break.disabled = true;
      gcloud.disabled    = true;
    };
  };
}
