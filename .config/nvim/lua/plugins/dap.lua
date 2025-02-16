return {
--   {
--     'mfussenegger/nvim-dap',
--     event = "VeryLazy",
--     config = function()
--       vim.cmd("highlight DapRed guifg=#EE4B2B")
--       vim.cmd("highlight DapBlue guifg=#0000FF")
--       vim.cmd("highlight DapGreen guifg=#7DB358")
--       vim.fn.sign_define('DapBreakpoint', { text = '⬤', texthl = 'DapRed' })
--       vim.fn.sign_define('DapBreakpointCondition', { text = '?', texthl = 'DapRed' })
--       vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapRed' })
--       vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapBlue' })
--       vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapGreen' })

--       require('dap').adapters.codelldb = {
--         type = 'server',
--         port = "${port}",
--         executable = {
--           command = 'codelldb',
--           args = { "--port", "${port}" },
--         }
--       }
--     end,
--   },

--   {
--     'nvim-telescope/telescope-dap.nvim',
--     event = "VeryLazy",
--     config = function()
--       require('telescope').load_extension('dap')
--     end,
--   },

--   { "nvim-neotest/nvim-nio" },

--   {
--     'rcarriga/nvim-dap-ui',
--     event = "VeryLazy",
--     dependencies = { 'mfussenegger/nvim-dap' },
--     config = true,
--   },

--   {
--     'theHamsta/nvim-dap-virtual-text',
--     event = "VeryLazy",
--     dependencies = { 'mfussenegger/nvim-dap' },
--     config = true,
--   },

--   {
--     'leoluz/nvim-dap-go',
--     event = "VeryLazy",
--     dependencies = { 'mfussenegger/nvim-dap' },
--     config = true,
--   },

--   {
--     'ldelossa/nvim-dap-projects',
--     event = "VeryLazy",
--   },
}
