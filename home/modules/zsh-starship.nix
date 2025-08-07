{ lib, config, ...}:
{
  programs.zsh.initContent = lib.mkIf config.programs.zsh.enable (
    lib.mkOrder 2000 ''
      eval "$(starship init zsh)"
    ''
  );
}
