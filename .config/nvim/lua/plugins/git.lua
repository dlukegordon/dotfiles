return {
  -- A Git wrapper so awesome, it should be illegal
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = {
      { "<leader>gm", ":G blame<CR>", desc = "Git [b]lame" },
    },
  },

  -- Link fugitive with github
  {
    "tpope/vim-rhubarb",
    event = "VeryLazy",
    keys = {
      { "<leader>gb", ":GBrowse<CR>", desc = "Open neo[g]it" },
      { "<leader>gb", ":GBrowse<CR>", desc = "Open neo[g]it", mode = "v" },
    },
  },

  -- Link fugitive with gitlab
  {
    "shumphrey/fugitive-gitlab.vim",
    event = "VeryLazy",
  },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  -- Magit for neovim
  -- {
  --   "NeogitOrg/neogit",
  --   event = "VeryLazy",
  --   branch = "master",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "sindrets/diffview.nvim",
  --   },
  --   config = {},
  --   keys = {
  --     { "<leader>gg", ":Neogit<CR>", { desc = "Open neo[g]it" } },
  --   },
  -- },
}
