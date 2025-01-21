return {
  {
    'windwp/nvim-autopairs',
    event = "VeryLazy",
    config = function()
      local apairs = require('nvim-autopairs')
      local Rule = require('nvim-autopairs.rule')
      apairs.setup {}
      apairs.add_rules { Rule('<', '>') }
    end
  },

  {
    'NMAC427/guess-indent.nvim',
    config = true,
  },

  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = true,
  },

  {
    'kylechui/nvim-surround',
    event = "VeryLazy",
    config = true,
  },

  {
    'ggandor/leap.nvim',
    event = "VeryLazy",
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  {
    'ggandor/leap-spooky.nvim',
    event = "VeryLazy",
    opts = { prefix = true },
  },

  {
    'ggandor/flit.nvim',
    event = "VeryLazy",
    config = true,
  },

}
