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
      inlay_hints = { enabled = false },
      servers = {
        gopls = {
          settings = {
            gopls = {
              completeUnimported = true,
              importShortcut = "Both",
              analyses = {
                undeclaredname = true,
              },
            },
          },
        },
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
        menu = {
          draw = {
            components = {
              label_description = {
                width = { max = 80 },
                text = function(ctx)
                    return ctx.label_description ~= '' and ctx.label_description or ctx.item.detail
                end,
              },
            },
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
          },
        },
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
        go = { "gopls" },
      },
    },
  },
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      { "<leader>A", function() require("harpoon"):list():add() end, desc = "harpoon file", },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
      {
        "<leader>a",
        function()
          local harpoon = require("harpoon")
          local list = harpoon:list()
          local raw = list.items or {}

          -- find highest numeric index (handles holes)
          local max_idx = 0
          for k in pairs(raw) do
            if type(k) == "number" and k > max_idx then max_idx = k end
          end

          -- build items; show holes as "— empty —"
          local items = {}
          if max_idx == 0 then
            items = { "— empty —" }
          else
            for i = 1, max_idx do
              local it = raw[i]
              items[#items + 1] = it and vim.fn.fnamemodify(it.value, ":~:.") or "— empty —"
            end
          end

          require("snacks.picker").select(
            items,
            { prompt = "Harpoon" },
            function(_, idx)
              if not idx then return end
              if not raw[idx] then
                vim.notify(("Harpoon slot %d is empty"):format(idx), vim.log.levels.INFO)
                return
              end
              list:select(idx)
            end
          )
        end,
        desc = "Harpoon: Quick Menu (Snacks, shows holes as empty)",
      },
      {
        "<leader>h",
        function()
          local list = require("harpoon"):list()
          list:remove()
        end,
        desc = "Harpoon: Remove current file",
      },
    },
  },
}
