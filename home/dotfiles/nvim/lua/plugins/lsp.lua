local function is_nixos()
  local stat = vim.loop.fs_stat("/etc/NIXOS")
  return stat and stat.type == "file"
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {},
        nixd = {},
        lua_ls = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "go",
        "nix",
        "lua",
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato", -- other options: latte, mocha, frappe, macchiato
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "saghen/blink.cmp",
    version = "v1.3.1",
    opts = {
      keymap = {
        preset = "super-tab",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    enabled = not is_nixos(), -- Conditionally disable mason.nvim on NixOS
  },
}
