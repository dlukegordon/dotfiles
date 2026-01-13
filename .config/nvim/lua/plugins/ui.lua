return {
  -- Themes
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").setup({
        colors = { bg0 = "#1d1e1b" },
      })
      require("bamboo").load()
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#272924" })
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        colorblind = {
          enable = true,
          severity = {
            protan = 1.0,
            deutan = 0.4,
            tritan = 0.2,
          },
        },
      },
    },
  },

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
  -- {
  --   "sphamba/smear-cursor.nvim",
  --   opts = {
  --     min_horizontal_distance_smear = 2,
  --     min_vertical_distance_smear = 2,
  --     never_draw_over_target = true,
  --   },
  -- },

  -- Better status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function get_cwd()
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
          lualine_x = { get_cwd, "diff", "branch" },
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
      delay = 1,
      preset = "helix",
      show_help = false,
      show_keys = false,
      icons = { rules = false },
      win = { border = "single" },
      -- Document existing key chains
      spec = {
        { "<leader>a", group = "All lines", mode = { "n", "x" } },
        { "<leader>b", group = "Buffers" },
        { "<leader>e", group = "Ai", mode = { "n", "x" } },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git", mode = { "n", "x" } },
        { "<leader>j", group = "Jump forward", mode = { "n", "x" } },
        { "<leader>k", group = "Jump backward", mode = { "n", "x" } },
        { "<leader>t", group = "Toggle" },
        { "<leader>w", group = "Window" },
      },
    },
  },

  -- Smooth scolling
  {
    "karb94/neoscroll.nvim",
    event = "VimEnter",
    config = function()
      local neoscroll = require("neoscroll")

      neoscroll.setup({
        mappings = {
          -- "<C-u>",
          -- "<C-d>",
          -- "<C-b>",
          -- "<C-f>",
          -- "<C-y>",
          -- "<C-e>",
          -- "zt",
          -- "zz",
          -- "zb",
        },
        stop_eof = false,
      })

      local hostname = vim.fn.trim(vim.fn.system("hostname"))

      -- Mouse wheel settings, for touchpad better to do nothing
      if hostname == "valhalla" then
        local keymap = vim.keymap.set
        local opts = { silent = true }

        keymap("n", "<ScrollWheelUp>", function()
          neoscroll.scroll(-10, { move_cursor = false, duration = 50 })
        end, opts)

        keymap("i", "<ScrollWheelUp>", function()
          neoscroll.scroll(-10, { move_cursor = false, duration = 50 })
        end, opts)

        keymap("v", "<ScrollWheelUp>", function()
          neoscroll.scroll(-10, { move_cursor = false, duration = 50 })
        end, opts)

        keymap("n", "<ScrollWheelDown>", function()
          neoscroll.scroll(10, { move_cursor = false, duration = 50 })
        end, opts)

        keymap("i", "<ScrollWheelDown>", function()
          neoscroll.scroll(10, { move_cursor = false, duration = 50 })
        end, opts)

        keymap("v", "<ScrollWheelDown>", function()
          neoscroll.scroll(10, { move_cursor = false, duration = 50 })
        end, opts)
      end
    end,
    keys = {
      {
        "<PageUp>",
        function()
          require("neoscroll").scroll(-0.5, { move_cursor = true, duration = 100 })
        end,
        mode = "n",
      },
      {
        "<PageUp>",
        function()
          require("neoscroll").scroll(-0.5, { move_cursor = true, duration = 100 })
        end,
        mode = "i",
      },
      {
        "<PageUp>",
        function()
          require("neoscroll").scroll(-0.5, { move_cursor = true, duration = 100 })
        end,
        mode = "v",
      },

      {
        "<PageDown>",
        function()
          require("neoscroll").scroll(0.5, { move_cursor = true, duration = 100 })
        end,
        mode = "n",
      },
      {
        "<PageDown>",
        function()
          require("neoscroll").scroll(0.5, { move_cursor = true, duration = 100 })
        end,
        mode = "i",
      },
      {
        "<PageDown>",
        function()
          require("neoscroll").scroll(0.5, { move_cursor = true, duration = 100 })
        end,
        mode = "v",
      },
    },
  },

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
      sign = { enabled = false },
      code = {
        border = "thin",
        width = "block",
        left_pad = 1,
        right_pad = 1,
        highlight = "RenderMarkdownH6Bg",
        highlight_border = "RenderMarkdownH6Bg",
      },
      heading = {
        enabled = false,
      },
    },

    ft = { "markdown", "Avante" },
  },

  -- Better markdown editing
  {
    "roodolv/markdown-toggle.nvim",
    opts = {
      filetypes = { "markdown" },
      use_default_keymaps = true,
    },
    ft = {
      "markdown",
    },
  },

  -- Delete a buffer without closing window
  { "famiu/bufdelete.nvim" },
}
