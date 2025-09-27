{ pkgs, ... }:
{
  home.packages = with pkgs; [
    starship
  ];

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "[$directory$git_branch$git_status]($style)$character";
      add_newline = false;
      line_break.disabled = true;

      directory = {
        truncation_length = 2;
        truncation_symbol = "…/";
        repo_root_style = "bold cyan";
        repo_root_format =
          "[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
      };

      git_status = {
        format     = "[$all_status]($style)";
        style      = "cyan";
        ahead      = "⇡\${count} ";
        diverged   = "⇕⇡\${ahead_count}⇣\${behind_count} ";
        behind     = "⇣\${count} ";
        conflicted = " ";
        up_to_date = " ";
        untracked  = "? ";
        modified   = " ";
        stashed    = "";
        staged     = "";
        renamed    = "";
        deleted    = "";
      };
    };
  };
}
