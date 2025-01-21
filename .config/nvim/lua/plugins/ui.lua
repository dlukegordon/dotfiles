return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker',
        -- Override for colorblindness
        colors = {
          red = '#ff6c6c',
          green = '#68c068',
          yellow = '#c0c03a',
        },
      }
      require('onedark').load()
    end,
  },

  -- {
  --   "askfiy/visual_studio_code",
  --   priority = 100,
  --   config = function()
  --     vim.cmd([[colorscheme visual_studio_code]])
  --   end,
  -- },

  {
    'nvim-tree/nvim-web-devicons',
    event = "VeryLazy",
    opts = {
      color_icons = true,
      default = true,
    },
  },

  {
    'goolord/alpha-nvim',
    config = function()
      local dashboard = require('alpha.themes.dashboard')
      local file, err = io.input(vim.fn.stdpath('config') .. '/static/neovim_banner.txt')
      dashboard.section.header.val = file:read("*a")
      dashboard.section.buttons.val = {}
      dashboard.section.footer.val = 'Onwards and upwards'
      dashboard.config.opts.noautocmd = true
      require('alpha').setup(dashboard.config)
    end,
  },

  { 'famiu/bufdelete.nvim' },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      -- local function last_part_cwd()
      --   local cwd = vim.loop.cwd()
      --   return '   ' .. cwd:match("([^/\\]+)$")
      -- end
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

        return '   ' .. new_cwd
      end

      local opts = {
        options = {
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'filetype',
            'diff',
            {
              'diagnostics',
              sources = {
                'nvim_lsp',
              }
            },
          },
          lualine_c = { { 'filename', file_status = true, path = 1, symbols = { unnamed = '∅' }, } },
          lualine_x = { cwd, 'branch' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', file_status = true, path = 3, symbols = { unnamed = '∅' }, } },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }

      require('lualine').setup(opts)
    end
  },

  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = true,
  },

  {
    'karb94/neoscroll.nvim',
    event = "VeryLazy",
    config = { stop_eof = false },
  },

  {
    'gelguy/wilder.nvim',
    event = "VeryLazy",
    dependencies = {
      'roxma/nvim-yarp',
      'nvim-web-devicons',
    },
    config = function()
      local wilder = require('wilder')
      wilder.setup { modes = { ':', '/', '?' } }

      wilder.set_option('pipeline', {
        wilder.branch(
          wilder.cmdline_pipeline({
            language = 'python',
            fuzzy = 1,
          }),
          wilder.python_search_pipeline({
            pattern = wilder.python_fuzzy_pattern(),
            sorter = wilder.python_difflib_sorter(),
            engine = 're',
          })
        ),
      })

      wilder.set_option('renderer', wilder.popupmenu_renderer({
        highlighter = wilder.basic_highlighter(),
        left = { ' ', wilder.popupmenu_devicons() },
        right = { ' ', wilder.popupmenu_scrollbar() },
      }))
    end,
  },

  {
    -- Needed for wilder.nvim
    'roxma/nvim-yarp',
    lazy = true,
    build = "pip install -r requirements.txt",
  },

  {
    'kevinhwang91/nvim-bqf',
    event = "VeryLazy",
  },

  {
    'folke/todo-comments.nvim',
    event = "VeryLazy",
    config = true,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = "VeryLazy",
    main = 'ibl',
    opts = { scope = { enabled = false, show_exact_scope = true } },
  },

  -- {
  --   "utilyre/barbecue.nvim",
  --   dependencies = { 'SmiteshP/nvim-navic' },
  --   opts = {
  --     theme = {
  --       dirname = { underline = true, bold = true },
  --       basename = { underline = true, bold = true },
  --       context = { underline = true, bold = true },
  --     }
  --   },
  -- },

  {
    'm00qek/baleia.nvim',
    -- event = "VeryLazy",
    config = function()
      vim.cmd([[
        let s:baleia = luaeval("require('baleia').setup { }")
        command! BaleiaColorize call s:baleia.once(bufnr('%'))
        autocmd FileType dap-repl call s:baleia.automatically(bufnr('%'))
      ]])
    end,
  },

  {
    'tzachar/local-highlight.nvim',
    config = true,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
}
