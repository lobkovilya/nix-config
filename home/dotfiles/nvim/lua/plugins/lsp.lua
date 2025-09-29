local function is_nixos()
  local stat = vim.loop.fs_stat("/etc/NIXOS")
  return stat and stat.type == "file"
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      news = { lazyvim = false, neovim = false },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {},
        nixd = {},
        lua_ls = {},
      },
      diagnostics = {
        virtual_text = false,
        virtual_lines = { current_line = true },
        update_in_insert = false,
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
      flavour = "latte", -- other options: latte, mocha, frappe, macchiato
      integrations = { neotree = true },
      custom_highlights = function(C)
        return {
          NeoTreeCursorLine = { bg = C.surface0 }, -- pick a darker shade (try C.mantle/surface0/surface1)
          CursorLine = { bg = C.surface0 },
          CursorColumn = { bg = C.surface0 },
        }
      end,
    },
  },
  {
    "saghen/blink.cmp",
    version = "v1.3.1",
    opts = {
      keymap = {
        preset = "super-tab",
      },
      completion = {
        -- don't pop the docs window while selecting with <Tab>, arrows, etc.
        documentation = { auto_show = false },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    enabled = not is_nixos(), -- Conditionally disable mason.nvim on NixOS
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    init = function()
      vim.g.rustaceanvim = {
        server = {
          settings = {
            ["rust-analyzer"] = {
              completion = {
                callable = {
                  -- "fill_arguments" (default), "add_parentheses", or "none"
                  snippets = "add_parentheses",
                },
              },
            },
          },
        },
      }
    end,
  },
  -- {
  --   "akinsho/bufferline.nvim",
  --   init = function()
  --     local bufline = require("catppuccin.groups.integrations.bufferline")
  --     function bufline.get()
  --       return bufline.get_theme()
  --     end
  --   end,
  -- },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        sh = {}, -- turn off shfmt
      },
    },
  },
}
