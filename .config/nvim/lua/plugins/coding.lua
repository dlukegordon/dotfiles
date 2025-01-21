return {
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'nvim-telescope/telescope.nvim',
      -- 'mrcjkb/rustaceanvim',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local cmp = require('cmp')
      local builtin = require('telescope.builtin')

      vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
      vim.opt.shortmess = vim.opt.shortmess + { c = true }
      vim.api.nvim_set_option('updatetime', 300)
      vim.cmd("autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })")

      ---------- Lspconfig
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
          -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wl', function()
          -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, opts)
          vim.keymap.set('n', 'gD', builtin.lsp_type_definitions)
          vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', builtin.lsp_references)
          vim.keymap.set('n', 'gi', builtin.lsp_incoming_calls)
          -- vim.keymap.set('n', '<space>f', function()
          --   vim.lsp.buf.format { async = true }
          -- end, opts)
        end,
      })

      ---------- Style
      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config {
        virtual_text = {
          prefix = '',
          format = function(diagnostic)
            local severity = diagnostic.severity
            local v_severity = vim.diagnostic.severity
            local icon = "?"
            if severity == v_severity.ERROR then
              icon = "󰅚 "
            elseif severity == v_severity.WARN then
              icon = "󰀪 "
            elseif severity == v_severity.HINT then
              icon = "󰌶 "
            elseif severity == v_severity.INFO then
              icon = " "
            end
            return string.format("%s %s", icon, diagnostic.message)
          end,
        },
        severity_sort = true,
        float = {
          source = "always",
        },
      }

      ---------- Cmp
      cmp.setup({
        -- Enable LSP snippets
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          -- ['<C-p>'] = cmp.mapping.select_prev_item(),
          -- ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Add tab support
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          -- ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-Space>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          })
        },
        -- Installed sources:
        sources = {
          { name = 'path' },                                       -- file paths
          { name = 'nvim_lsp',               keyword_length = 1 }, -- from language server
          { name = 'nvim_lsp_signature_help' },                    -- display function signatures with current parameter emphasized
          { name = 'nvim_lua',               keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
          { name = 'buffer',                 keyword_length = 3 }, -- source current buffer
          { name = 'vsnip',                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
          { name = 'calc' },                                       -- source for math calculation
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { 'menu', 'abbr', 'kind' },
          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = ' ',
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },
      })

      ---------- Formatting
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.lua", "*.rs", "*.go", "*.yml" },
        callback = function() vim.lsp.buf.format { async = false } end,
      })

      ---------- Langs
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            analyses = {
              unusedparams = false,
            },
          },
        },
      })
      lspconfig.golangci_lint_ls.setup({})
      lspconfig.yamlls.setup({})
      lspconfig.bashls.setup({})
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })
      lspconfig.rust_analyzer.setup({
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            checkOnSave = true,
            check = {
              enable = true,
              command = 'clippy',
              features = 'all',
            },
          },
        },
      })
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    event = "VeryLazy",
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = true,
  },

  -- {
  --   'mrcjkb/rustaceanvim',
  --   event = "VeryLazy",
  --   ft = { 'rust' },
  --   config = function()
  --     vim.g.rustaceanvim = {
  --       -- LSP configuration
  --       server = {
  --         settings = {
  --           ['rust-analyzer'] = {
  --             cargo = { allFeatures = true },
  --             checkOnSave = true,
  --             check = {
  --               enable = true,
  --               command = 'clippy',
  --               features = 'all',
  --             },
  --             procMacro = {
  --               enable = true,
  --             },
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },

  {
    "pmizio/typescript-tools.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  {
    'vim-test/vim-test',
    event = "VeryLazy",
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "openai",
      hints = { enabled = false },
      windows = {
        sidebar_header = {
          enabled = true,  -- true, false to enable/disable the header
          align = "right", -- left, center, right for title
          rounded = false,
        },
      }
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  }
}
