return {
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.setup({
        check_ts = true,
      })
      -- npairs.clear_rules()
      -- npairs.add_rule(Rule("{", "}"))
      npairs.add_rule(Rule("<", ">"))
    end,
  },

  -- Collection of various small independent plugins/modules
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.comment").setup()

      require("mini.files").setup({
        options = {
          use_as_default_explorer = false,
        },
        windows = {
          preview = true,
          width_preview = 100,
        },
      })
      vim.keymap.set("n", "_", ":lua MiniFiles.open()<CR>", { desc = "Open mini file browser" })
    end,
  },

  -- Handy additional textobjects
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    config = {
      keymaps = {
        useDefaults = true,
        disabledDefaults = { "io", "ao", "in", "an", "n", "iS", "aS" },
      },
    },
    -- Must be ex commands, not lua, for . repeat to work
    keys = {
      { "iu", "<cmd>lua require('various-textobjs').subword('inner')<CR>", mode = { "o", "x" } },
      { "au", "<cmd>lua require('various-textobjs').subword('outer')<CR>", mode = { "o", "x" } },
      -- { "iu", "<cmd>lua require('various-textobjs').number('inner')<CR>", mode = { "o", "x" } },
      -- { "au", "<cmd>lua require('various-textobjs').number('outer')<CR>", mode = { "o", "x" } },
      { "N",  "<cmd>lua require('various-textobjs').nearEoL()<CR>",        mode = { "o", "x" } },
    },
  },

  -- Edit surrounding pairs
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = {
      keymaps = {
        insert = "<C-g>z",
        insert_line = "<C-g>Z",
        normal = "gz",
        normal_line = "gZ",
        normal_cur = "gzz",
        normal_cur_line = "gZZ",
        visual = "gz",
        visual_line = "gZ",
        delete = "gzd",
        change = "gzc",
      },
      aliases = {
        ["a"] = ">",
        ["b"] = ")",
        ["B"] = "}",
        ["r"] = "]",
        ["q"] = { '"', "'", "`" },
        ["z"] = { "}", "]", ")", ">", '"', "'", "`" },
      },
    },
  },

  {
    "smoka7/hop.nvim",
    config = {},
    keys = {
      { "s", ":HopWord<CR>", mode = { "n" } },
    },
  },

  -- Neovim's answer to the mouse
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      -- require("leap").create_default_mappings()
    end,
  },

  -- Use leap for f/F/t/T
  {
    "ggandor/flit.nvim",
    event = "VeryLazy",
    config = true,
  },

  -- Increment and decrement
  {
    "monaqa/dial.nvim",
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%m/%d"],
          augend.date.alias["%H:%M"],
          augend.constant.alias.bool,
        },
      })
    end,
    keys = {
      {
        "<c-a>",
        function()
          require("dial.map").manipulate("increment", "normal")
        end,
        desc = "Increment with dial",
      },
      {
        "<c-x>",
        function()
          require("dial.map").manipulate("decrement", "normal")
        end,
        desc = "Decrement with dial",
      },
      {
        "g<c-a>",
        function()
          require("dial.map").manipulate("increment", "gnormal")
        end,
        desc = "Increment with dial",
      },
      {
        "g<c-x>",
        function()
          require("dial.map").manipulate("decrement", "gnormal")
        end,
        desc = "Decrement with dial",
      },
      {
        "<C-a>",
        function()
          require("dial.map").manipulate("increment", "visual")
        end,
        desc = "Increment with dial",
        mode = "v",
      },
      {
        "<C-x>",
        function()
          require("dial.map").manipulate("decrement", "visual")
        end,
        desc = "Decrement with dial",
        mode = "v",
      },
      {
        "g<C-a>",
        function()
          require("dial.map").manipulate("increment", "gvisual")
        end,
        desc = "Increment with dial",
        mode = "v",
      },
      {
        "g<C-x>",
        function()
          require("dial.map").manipulate("decrement", "gvisual")
        end,
        desc = "Decrement with dial",
        mode = "v",
      },
    },
  },

  -- Autoformat
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = "never"
        else
          lsp_format_opt = "fallback"
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixfmt" },
      },
      formatters = {
        stylua = {
          prepend_args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
          },
        },
      },
    },
  },
}
