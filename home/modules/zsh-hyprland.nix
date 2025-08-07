{ lib, config, ...}:
{
  programs.zsh.initContent = lib.mkIf config.programs.zsh.enable (
    lib.mkOrder 2000 ''
      if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland
      fi
    ''
  );
}
