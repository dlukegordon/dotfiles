return {
  {
    'tpope/vim-fugitive',
    event = "VeryLazy",
    config = function()
      -- Fix GBrowse not working with oil as default (oil breaks netrw, Gbrowse requires netrw)
      -- From: https://vi.stackexchange.com/questions/38447/vim-fugitive-netrw-not-found-define-your-own-browse-to-use-gbrowse
      vim.api.nvim_create_user_command(
        'Browse',
        function(opts)
          vim.fn.system { 'open', opts.fargs[1] }
        end,
        { nargs = 1 }
      )
    end,
  },
  {
    'tpope/vim-rhubarb',
    event = "VeryLazy",
  },
  {
    'shumphrey/fugitive-gitlab.vim',
    event = "VeryLazy",
  },
  {
    'lewis6991/gitsigns.nvim',
    event = "VeryLazy",
    config = true
  },
  {
    'NeogitOrg/neogit',
    event = "VeryLazy",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    config = true,
    branch = 'master',
  },
}
