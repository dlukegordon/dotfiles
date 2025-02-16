return {
  -- Highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,

          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",

            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",

            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",

            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",

            ["ay"] = "@return.outer",
            ["iy"] = "@return.inner",

            ["ad"] = "@comment.outer",
            ["id"] = "@comment.inner",

            ["ao"] = "@block.outer",
            ["io"] = "@block.inner",

            ["ar"] = "@class.outer",
            ["ir"] = "@class.inner",

            ["ae"] = "@call.outer",
            ["ie"] = "@call.inner",

            ["an"] = "@assignment.outer",
            ["in"] = "@assignment.inner",
            ["nh"] = "@assignment.lhs",
            ["nl"] = "@assignment.rhs",

            ["m"] = "@statement.outer",
          },
        },
        -- move = {
        --   enable = true,
        --   set_jumps = true, -- whether to set jumps in the jumplist
        --   goto_next_start = {
        --     ["<leader>jf"] = "@function.outer",
        --     ["<leader>jF"] = "@function.inner",
        --
        --     ["<leader>jl"] = "@loop.outer",
        --     ["<leader>jL"] = "@loop.inner",
        --
        --     ["<leader>ja"] = "@parameter.outer",
        --     ["<leader>jA"] = "@parameter.inner",
        --   },
        -- },
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
