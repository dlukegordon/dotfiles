return {
  -- A Git wrapper so awesome, it should be illegal
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = {
      { "<leader>gm", ":G blame<CR>", desc = "Git blame" },
    },
  },

  -- Link fugitive with github
  {
    "tpope/vim-rhubarb",
    event = "VeryLazy",
    keys = {
      { "<leader>gb", ":GBrowse!<CR>", desc = "Browse github" },
      { "<leader>gb", ":GBrowse!<CR>", desc = "Browse github", mode = "v" },
    },
  },

  -- Link fugitive with gitlab
  -- {
  --   "shumphrey/fugitive-gitlab.vim",
  --   event = "VeryLazy",
  -- },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "<leader>jc", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Goto next git change" })

        map("n", "<leader>kc", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Goto previous git change" })

        map("n", "<leader>gl", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "Git blame line" })

        map("n", "<leader>gq", gitsigns.setqflist, { desc = "Load buffer hunks into quickfix list" })
        map("n", "<leader>gQ", function()
          gitsigns.setqflist("all")
        end, { desc = "Load project hunks into quickfix list" })

        map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select git hunk" })
      end,
    },
  },

  -- Magit for neovim
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {},
    keys = {
      { "<leader>gg", ":Neogit<CR>", { desc = "Open neogit" } },
    },
  },
}
