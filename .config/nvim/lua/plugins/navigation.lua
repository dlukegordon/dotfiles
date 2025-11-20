return {
  -- Edit your filesystem like a normal neovim buffer
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["q"] = "actions.close",
      },
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      {
        "-",
        ":Oil<CR>",
        -- function()
        --   require("oil").open(nil, { preview = {} })
        -- end,
        { desc = "Open oil file browser" },
      },
    },
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
            },
          },

          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.9,
              prompt_position = "top",
              preview_width = 0.495,
            },
          },
          sorting_strategy = "ascending",

          borderchars = {
            prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          },
          file_ignore_patterns = { ".git/", "deps/", "node_modules/" },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
        },
      })

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>'", builtin.resume, { desc = "Resume last search" })
      vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Find diagnostics" })
      vim.keymap.set("n", "<leader>l", builtin.oldfiles, { desc = "Find last files" })
      vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>ff", builtin.current_buffer_fuzzy_find, { desc = "Find in the current buffer" })
      vim.keymap.set("n", "<leader>fF", function()
        builtin.find_files({ hidden = true })
      end, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
      vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find current word" })
      vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Find jumplist" })
      vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Find marks" })
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last find" })

      vim.keymap.set("n", "<leader><leader>", function()
        builtin.find_files({ hidden = true })
      end, { desc = "Find files" })

      vim.keymap.set("n", "<leader>f/", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live grep in open files",
        })
      end, { desc = "Find in open files" })
    end,
  },

  -- -- Seamlessly navigate between neovim and wezterm
  -- {
  --   "mrjones2014/smart-splits.nvim",
  --   lazy = false,
  --   config = {},
  --   keys = {
  --     { "<C-h>", "<cmd>SmartCursorMoveLeft<cr>" },
  --     { "<C-j>", "<cmd>SmartCursorMoveDown<cr>" },
  --     { "<C-k>", "<cmd>SmartCursorMoveUp<cr>" },
  --     { "<C-l>", "<cmd>SmartCursorMoveRight<cr>" },
  --     { "<A-h>", "<cmd>SmartResizeLeft<cr>" },
  --     { "<A-j>", "<cmd>SmartResizeDown<cr>" },
  --     { "<A-k>", "<cmd>SmartResizeUp<cr>" },
  --     { "<A-l>", "<cmd>SmartResizeRight<cr>" },
  --   },
  -- },

  -- Seamlessly navigate between neovim and tmux
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- Better marks
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- File tree
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   event = "VeryLazy",
  --   config = {
  --     sync_root_with_cwd = true,
  --     respect_buf_cwd = true,
  --     update_focused_file = {
  --       enable = true,
  --       update_root = true,
  --     },
  --     diagnostics = {
  --       enable = true,
  --       show_on_dirs = true,
  --       icons = {
  --         hint = "󰌶 ",
  --         info = " ",
  --         warning = "󰀪 ",
  --         error = "󰅚 ",
  --       },
  --     },
  --   },
  --   -- Toggle and go back to previous window
  --   -- keys = {
  --   --   {
  --   --     "<leader>tt",
  --   --     function()
  --   --       local nvim_tree = require("nvim-tree.api")
  --   --       if nvim_tree.tree.is_visible() then
  --   --         nvim_tree.tree.toggle()
  --   --       else
  --   --         nvim_tree.tree.toggle()
  --   --         vim.cmd("wincmd p")
  --   --       end
  --   --     end,
  --   --     desc = "Toggle NvimTree",
  --   --   },
  --   -- },
  -- },

  -- Grug-far
  {
    "MagicDuck/grug-far.nvim",
    opts = {},
    keys = {
      { "<leader>fg", ":GrugFar<CR>", desc = "Find with GrugFar" },
    },
  },

  {
    "stevearc/aerial.nvim",
    opts = {
      -- filter_kind = {
      --   "Array",
      --   "Boolean",
      --   "Class",
      --   "Constant",
      --   "Constructor",
      --   "Enum",
      --   "EnumMember",
      --   "Event",
      --   "Field",
      --   "File",
      --   "Function",
      --   "Interface",
      --   "Key",
      --   "Method",
      --   "Module",
      --   "Namespace",
      --   "Null",
      --   "Number",
      --   "Object",
      --   "Operator",
      --   "Package",
      --   "Property",
      --   "String",
      --   "Struct",
      --   "TypeParameter",
      --   "Variable",
      -- },
      filter_kind = false,
      autojump = true,
      close_on_select = true,
      nav = {
        autojump = true,
      },
    },
    keys = {
      { "<leader>c", ":AerialToggle<CR>", desc = "Code outline" },
      { "<leader>jj", ":AerialNext<CR>", desc = "Goto next code structure" },
      { "<leader>kk", ":AerialPrev<CR>", desc = "Goto previous code structure" },
    },
  },
}
