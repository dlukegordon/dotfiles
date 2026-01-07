return {
  {
    "zbirenbaum/copilot-cmp",
    opts = {},
  },

  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
      nes = { enabled = false },
    },
  },

  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        provider = {
          enabled = "tmux",
          tmux = {
            options = "-hb",
          },
        },
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      vim.keymap.set({ "n", "x" }, "<leader>ea", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode" })

      vim.keymap.set({ "n", "x" }, "<leader>es", function()
        require("opencode").select()
      end, { desc = "Select opencode action" })

      vim.keymap.set({ "n", "x" }, "<leader>ee", function()
        return require("opencode").operator("@this ")
      end, { expr = true, desc = "Add range to opencode" })

      vim.keymap.set("n", "<leader>ee", function()
        return require("opencode").operator("@this ") .. "_"
      end, { expr = true, desc = "Add line to opencode" })

      vim.keymap.set("n", "<leader>ed", function()
        require("opencode").prompt("Explain @diagnostics", { clear = true, submit = true })
      end, { expr = true, desc = "Explain diagnostics" })

      vim.keymap.set({ "n", "x" }, "<leader>ex", function()
        require("opencode").prompt("Explain @this and its context", { clear = true, submit = true })
      end, { expr = true, desc = "Explain this" })

      vim.keymap.set({ "n", "x" }, "<leader>ef", function()
        require("opencode").prompt("Fix @diagnostics", { clear = true, submit = true })
      end, { expr = true, desc = "Fix diagnostics" })
    end,
  },
}
