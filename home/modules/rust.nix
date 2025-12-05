{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Rust toolchain manager
    # rustup manages rustc, cargo, rust-analyzer, rustfmt, clippy, etc.
    rustup

    # Additional Rust development tools
    cargo-watch  # Auto-rebuild on file changes
    cargo-edit   # cargo add, cargo rm, cargo upgrade commands
    cargo-audit  # Security vulnerability scanner
  ];

  home.sessionVariables = {
    # Ensure cargo binaries are in PATH
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
