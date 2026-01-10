return {
  -- Highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").move = {
            tier = 1,
            install_info = {
              url = "",
              revision = "",
              path = "/home/luke/mysten/sui/external-crates/move/tooling/tree-sitter/",
            },
          }
        end,
      })

      require("nvim-treesitter")
        .install({
          "bash",
          "c",
          "diff",
          "html",
          "json",
          "kdl",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "move",
          "nix",
          "nu",
          "query",
          "rust",
          "vim",
          "vimdoc",
          "yaml",
        })
        :wait(60000)

      vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*",
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "af",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.outer")
        end,
        mode = { "x", "o" },
        desc = "Select around function",
      },
      {
        "if",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.inner")
        end,
        mode = { "x", "o" },
        desc = "Select inside function",
      },
      {
        "al",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer")
        end,
        mode = { "x", "o" },
        desc = "Select around loop",
      },
      {
        "il",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner")
        end,
        mode = { "x", "o" },
        desc = "Select inside loop",
      },
      {
        "aa",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer")
        end,
        mode = { "x", "o" },
        desc = "Select around parameter",
      },
      {
        "ia",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner")
        end,
        mode = { "x", "o" },
        desc = "Select inside parameter",
      },
      {
        "ac",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer")
        end,
        mode = { "x", "o" },
        desc = "Select around conditional",
      },
      {
        "ic",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner")
        end,
        mode = { "x", "o" },
        desc = "Select inside conditional",
      },
      {
        "ay",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@return.outer")
        end,
        mode = { "x", "o" },
        desc = "Select around return",
      },
      {
        "iy",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@return.inner")
        end,
        mode = { "x", "o" },
        desc = "Select inside return",
      },
      {
        "ad",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@comment.outer")
        end,
        mode = { "x", "o" },
        desc = "Select around comment",
      },
      {
        "id",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@comment.inner")
        end,
        mode = { "x", "o" },
        desc = "Select inside comment",
      },
      {
        "ao",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@block.outer")
        end,
        mode = { "x", "o" },
        desc = "Select around block",
      },
      {
        "io",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@block.inner")
        end,
        mode = { "x", "o" },
        desc = "Select inside block",
      },
      {
        "ar",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.outer")
        end,
        mode = { "x", "o" },
        desc = "Select around class",
      },
      {
        "ir",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.inner")
        end,
        mode = { "x", "o" },
        desc = "Select inside class",
      },
      {
        "ae",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@call.outer")
        end,
        mode = { "x", "o" },
        desc = "Select around call",
      },
      {
        "ie",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@call.inner")
        end,
        mode = { "x", "o" },
        desc = "Select inside call",
      },
      {
        "an",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@assignment.outer")
        end,
        mode = { "x", "o" },
        desc = "Select around assignment",
      },
      {
        "in",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@assignment.inner")
        end,
        mode = { "x", "o" },
        desc = "Select inside assignment",
      },
      {
        "nh",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@assignment.lhs")
        end,
        mode = { "x", "o" },
        desc = "Select lhs of assignment",
      },
      {
        "nl",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@assignment.rhs")
        end,
        mode = { "x", "o" },
        desc = "Select rhs of assignment",
      },
      {
        "x",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@statement.outer")
        end,
        mode = { "x", "o" },
        desc = "Select around statement",
      },
      {
        "<leader>jf",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer")
        end,
        mode = "n",
        desc = "Goto next start of outer function",
      },
      {
        "<leader>jF",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@function.inner")
        end,
        mode = "n",
        desc = "Goto next start of inner function",
      },
      {
        "<leader>jr",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer")
        end,
        mode = "n",
        desc = "Goto next start of outer class",
      },
      {
        "<leader>jR",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@class.inner")
        end,
        mode = "n",
        desc = "Goto next start of inner class",
      },

      {
        "<leader>kf",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer")
        end,
        mode = "n",
        desc = "Goto previous start of outer function",
      },
      {
        "<leader>kF",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@function.inner")
        end,
        mode = "n",
        desc = "Goto previous start of inner function",
      },
      {
        "<leader>kr",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer")
        end,
        mode = "n",
        desc = "Goto previous start of outer class",
      },
      {
        "<leader>kR",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@class.inner")
        end,
        mode = "n",
        desc = "Goto previous start of inner class",
      },
    },
  },
}
