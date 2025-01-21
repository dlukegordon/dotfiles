return {
  {
    'stevearc/oil.nvim',
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
  },

  {
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        file_ignore_patterns = { ".git/", "deps/", "node_modules/", ".venv/" },
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
    },
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-telescope/telescope.nvim' },
    build = 'make',
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },

  {
    'chentoast/marks.nvim',
    event = "VeryLazy",
    config = true,
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
  },

  { "RyanMillerC/better-vim-tmux-resizer" },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    opts = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true
      },
    }
  },

  -- { 'chaoren/vim-wordmotion' }
}
