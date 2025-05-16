return {
  -- Edit your filesystem like a normal neovim buffer
  {
    "stevearc/oil.nvim",
    config = {
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
      { "-", ":Oil<CR>", { desc = "Open oil file browser" } },
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

      vim.keymap.set("n", "<A-f>", builtin.current_buffer_fuzzy_find, { desc = "Search the current buffer" })
      vim.keymap.set("n", "<leader>'", builtin.resume, { desc = "Resume last search" })
      vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Search [b]uffers" })
      vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Search [d]iagnostics" })
      vim.keymap.set("n", "<leader>l", builtin.oldfiles, { desc = "Search [l]ast files" })
      vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search [h]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search [k]eymaps" })
      vim.keymap.set("n", "<leader>sc", builtin.grep_string, { desc = "Search [c]urrent word" })
      vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "Search [j]umplist" })
      vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "Search [m]arks" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[R]esume last search" })

      vim.keymap.set("n", "<leader><leader>", function()
        builtin.find_files({ hidden = true })
      end, { desc = "Search files" })

      vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end, { desc = "Search in open files" })
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
    config = {},
  },

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "󰌶 ",
          info = " ",
          warning = "󰀪 ",
          error = "󰅚 ",
        },
      },
    },
    -- Toggle and go back to previous window
    keys = {
      -- { "<leader>tt", ":NvimTreeToggle<CR>:wincmd w<CR>", desc = "Toggle NvimTree" },
      {
        "<leader>tt",
        function()
          local nvim_tree = require("nvim-tree.api")
          if nvim_tree.tree.is_visible() then
            nvim_tree.tree.toggle()
          else
            nvim_tree.tree.toggle()
            vim.cmd("wincmd p")
          end
        end,
        desc = "Toggle NvimTree",
      },
    },
  },

  -- Grug-far
  {
    "MagicDuck/grug-far.nvim",
    config = {},
    keys = {
      { "<leader>sg", ":GrugFar<CR>", desc = "[S]earch with grug-far" },
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
      { "<leader>a", ":AerialToggle<CR>", desc = "Open aerial outline" },
      { "<leader>jj", ":AerialNext<CR>", desc = "Goto next code structure" },
      { "<leader>kk", ":AerialPrev<CR>", desc = "Goto previous code structure" },
    },
  },
}
