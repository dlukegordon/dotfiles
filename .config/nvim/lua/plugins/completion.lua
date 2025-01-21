return {
  { 'hrsh7th/nvim-cmp',                    event = "VeryLazy" },
  { 'hrsh7th/cmp-nvim-lsp',                event = "VeryLazy" },
  { 'hrsh7th/cmp-nvim-lua',                event = "VeryLazy" },
  { 'hrsh7th/cmp-nvim-lsp-signature-help', event = "VeryLazy" },
  { 'hrsh7th/cmp-vsnip',                   event = "VeryLazy" },
  { 'hrsh7th/cmp-path',                    event = "VeryLazy" },
  { 'hrsh7th/cmp-buffer',                  event = "VeryLazy" },
  { 'hrsh7th/vim-vsnip',                   event = "VeryLazy" },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VeryLazy",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-CR>",
          accept_word = "<C-\\>",
          accept_line = false,
          next = "<C-c>",
          -- prev = "<C-x>",
          dismiss = "<C-d>",
        }
      }
    }
  },
}
