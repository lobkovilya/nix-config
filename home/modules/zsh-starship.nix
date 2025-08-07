{ lib, config, ...}:
{
  programs.zsh.initContent = lib.mkIf config.programs.zsh.enable ''
    ${config.programs.zsh.initContent or ""}
    eval "$(starship init zsh)"
  '';
}
