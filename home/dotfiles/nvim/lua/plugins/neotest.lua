return {
  -- ✅ Live streaming task runner
  {
    "stevearc/overseer.nvim",
    opts = {
      strategy = { "terminal" }, -- streams output live
      task_list = { direction = "bottom", min_height = 8, max_height = 20, default_detail = 1 },
    },
  },

  -- ✅ Neotest core
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",         -- REQUIRED (fixes "module 'nio' not found")
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "stevearc/overseer.nvim",

      {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = function()
          vim.cmd(":TSUpdate go")
        end,
      },
      {
        "fredrikaverpil/neotest-golang", -- ✅ correct adapter
        version = "*",
        build = function()
          -- optional but convenient
          vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
        end,
      },
    },

    config = function()
      local neotest = require("neotest")
      local overseer = require("overseer")

      neotest.setup({
        adapters = {
          require("neotest-golang")({
            go_test_args = { "-count=1", "-timeout=60s" },
            runner = "gotestsum", -- optional, defaults to "gotestsum" anyway
          }),
        },
        consumers = {
          overseer = require("neotest.consumers.overseer"),
        },
      })

      -- Single key mapping
      vim.keymap.set("n", "<leader>tr", function()
        -- Clear previous tasks (no appended output)
        for _, task in ipairs(overseer.list_tasks({ recent = true })) do
          task:dispose(true)
        end

        -- Run nearest test via overseer (live streaming)
        neotest.run.run({ strategy = "overseer" })

        -- Open bottom panel, keep focus in code window
        overseer.open({ direction = "bottom", enter = false })
      end, { desc = "Run nearest test (live output panel)" })
    end,
  },
}

