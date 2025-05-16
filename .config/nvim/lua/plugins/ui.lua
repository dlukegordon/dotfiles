return {
  -- Themes
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").setup({})
      require("bamboo").load()
    end,
  },
  -- "Mofiqul/vscode.nvim",
  -- "tomasiser/vim-code-dark",
  -- "christianchiarulli/nvcode-color-schemes.vim",
  -- "marko-cerovac/material.nvim",

  -- Custom start screen
  {
    "piperinnshall/boot.nvim",
    config = function()
      local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
      local color = string.format("%06x", hl.fg)
      require("boot").setup({
        directory = "boot.themes",
        theme = {
          "neovim",
          content = {
            {
              ascii = {
                "     ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗    ",
                "     ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║    ",
                "     ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║    ",
                "     ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║    ",
                "     ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║    ",
                "     ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝    ",
              },
              color = color,
              alignment = "center",
              vertical_padding = 20,
            },
          },
        },
      })
    end,
  },

  -- Fancy flying cursor
  {
    "sphamba/smear-cursor.nvim",
    opts = { legacy_computing_symbols_support = true },
  },

  -- Better status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function cwd()
        local cwd = vim.loop.cwd()
        local home = os.getenv("HOME")
        local new_cwd
        -- Replace home directory path with ~
        if home and cwd:sub(1, #home) == home then
          new_cwd = "~" .. cwd:sub(#home + 1)
        else
          new_cwd = cwd
        end
        return "   " .. new_cwd
      end

      local function lines_cols()
        local lines = vim.api.nvim_buf_line_count(0)
        local current_line = vim.api.nvim_get_current_line()
        local cols = vim.fn.strdisplaywidth(current_line)
        return string.format("%d:%d", lines, cols)
      end

      local opts = {
        options = {
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            { "filetype", icon_only = true },
            {
              "diagnostics",
              sources = {
                "nvim_lsp",
              },
            },
          },
          lualine_c = { { "filename", file_status = true, path = 1, symbols = { unnamed = "∅" } } },
          lualine_x = { cwd, "diff", "branch" },
          lualine_y = { "progress", lines_cols },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { "filename", file_status = true, path = 3, symbols = { unnamed = "∅" } } },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }

      require("lualine").setup(opts)
    end,
  },

  -- Useful plugin to show you pending keybinds
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
      delay = 200,
      -- Document existing key chains
      spec = {
        { "<leader>b", group = "[B]uffers" },
        { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
        { "<leader>g", group = "[G]it" },
        { "<leader>j", group = "[J]ump forward" },
        { "<leader>k", group = "Jump bac[k]ward" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>w", group = "[W]indow" },
      },
    },
  },

  -- Smooth scolling
  -- {
  --   "karb94/neoscroll.nvim",
  --   event = "VimEnter",
  --   config = {
  --     mappings = {
  --       "<C-u>",
  --       "<C-d>",
  --       "<C-b>",
  --       "<C-f>",
  --       "<C-y>",
  --       "<C-e>",
  --       "zt",
  --       "zz",
  --       "zb",
  --     },
  --     stop_eof = false,
  --   },
  --   keys = {
  --     -- {
  --     --   "<PageUp>",
  --     --   function()
  --     --     require("neoscroll").scroll(-0.5, { move_cursor = true, duration = 100 })
  --     --   end,
  --     --   mode = "n",
  --     -- },
  --     -- {
  --     --   "<PageUp>",
  --     --   function()
  --     --     require("neoscroll").scroll(-0.5, { move_cursor = true, duration = 100 })
  --     --   end,
  --     --   mode = "i",
  --     -- },
  --     -- {
  --     --   "<PageUp>",
  --     --   function()
  --     --     require("neoscroll").scroll(-0.5, { move_cursor = true, duration = 100 })
  --     --   end,
  --     --   mode = "v",
  --     -- },
  --     --
  --     -- {
  --     --   "<PageDown>",
  --     --   function()
  --     --     require("neoscroll").scroll(0.5, { move_cursor = true, duration = 100 })
  --     --   end,
  --     --   mode = "n",
  --     -- },
  --     -- {
  --     --   "<PageDown>",
  --     --   function()
  --     --     require("neoscroll").scroll(0.5, { move_cursor = true, duration = 100 })
  --     --   end,
  --     --   mode = "i",
  --     -- },
  --     -- {
  --     --   "<PageDown>",
  --     --   function()
  --     --     require("neoscroll").scroll(0.5, { move_cursor = true, duration = 100 })
  --     --   end,
  --     --   mode = "v",
  --     -- },
  --     --
  --     -- {
  --     --   "<ScrollWheelUp>",
  --     --   function()
  --     --     require("neoscroll").scroll(-15, { move_cursor = false, duration = 70 })
  --     --   end,
  --     --   mode = "n",
  --     -- },
  --     -- {
  --     --   "<ScrollWheelUp>",
  --     --   function()
  --     --     require("neoscroll").scroll(-15, { move_cursor = false, duration = 70 })
  --     --   end,
  --     --   mode = "i",
  --     -- },
  --     -- {
  --     --   "<ScrollWheelUp>",
  --     --   function()
  --     --     require("neoscroll").scroll(-15, { move_cursor = false, duration = 70 })
  --     --   end,
  --     --   mode = "v",
  --     -- },
  --     --
  --     -- {
  --     --   "<ScrollWheelDown>",
  --     --   function()
  --     --     require("neoscroll").scroll(15, { move_cursor = false, duration = 70 })
  --     --   end,
  --     --   mode = "n",
  --     -- },
  --     -- {
  --     --   "<ScrollWheelDown>",
  --     --   function()
  --     --     require("neoscroll").scroll(15, { move_cursor = false, duration = 70 })
  --     --   end,
  --     --   mode = "i",
  --     -- },
  --     -- {
  --     --   "<ScrollWheelDown>",
  --     --   function()
  --     --     require("neoscroll").scroll(15, { move_cursor = false, duration = 70 })
  --     --   end,
  --     --   mode = "v",
  --     -- },
  --   },
  -- },

  -- Better quickfix window
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
  },

  -- Better markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },

  -- Delete a buffer without closing window
  { "famiu/bufdelete.nvim" },
}
