vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "\\", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("v", "\\", "gc", { remap = true, desc = "Comment lines" })
vim.keymap.set("n", "<CR>", "G", { remap = true, desc = "[G]oto line" })

vim.keymap.set("n", "<A-s>", ":w<CR>", { desc = "Save the buffer" })
vim.keymap.set("i", "<A-s>", "<ESC>:w<CR>", { desc = "Save the buffer" })
vim.keymap.set("v", "<A-s>", ":w<CR>", { desc = "Save the buffer" })
vim.keymap.set("n", "<A-a>", "ggVG", { desc = "Select all" })
vim.keymap.set("i", "<A-a>", "<ESC>ggVG", { desc = "Select all" })
vim.keymap.set("v", "<A-a>", "ggVG", { desc = "Select all" })

vim.keymap.set("n", "<leader>bd", ":Bdelete<CR>", { desc = "[D]elete buffer" })
vim.keymap.set("n", "<leader>bl", ":b#<CR>", { desc = "Go to [l]ast buffer" })

vim.keymap.set("n", "<leader>q", ":qa<CR>", { desc = "[Q]uit neovim" })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "[Q]uit neovim without saving" })

vim.keymap.set("n", "<leader>ww", function()
  local current_win = vim.fn.winnr()
  local prev_win = vim.fn.winnr("#")
  if prev_win ~= current_win then
    vim.cmd("wincmd p")
  else
    vim.cmd("wincmd w")
  end
end, { desc = "Switch to last or next window" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window [v]ertically" })
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window [h]orizontally" })
vim.keymap.set("n", "<leader>wd", "<C-w>q", { desc = "[D]elete window" })
vim.keymap.set("n", "<leader>jd", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>kd", vim.diagnostic.goto_prev)
vim.keymap.set("v", "<leader>o", ":sort<CR>", { desc = "S[o]rt/[O]rder" })

-- Swap PageUp/PageDown and C-u/C-d
-- vim.keymap.set("n", "<PageUp>", "<C-u>", { noremap = true, silent = true })
-- vim.keymap.set("v", "<PageUp>", "<C-u>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<PageDown>", "<C-d>", { noremap = true, silent = true })
-- vim.keymap.set("v", "<PageDown>", "<C-d>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-u>", "<PageUp>", { noremap = true, silent = true })
-- vim.keymap.set("v", "<C-u>", "<PageUp>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-d>", "<PageDown>", { noremap = true, silent = true })
-- vim.keymap.set("v", "<C-d>", "<PageDown>", { noremap = true, silent = true })

-- " Function key mappings
-- nnoremap <F5> :lua require('nvim-dap-projects').search_project_config()<CR>:lua require("dapui").open()<CR>:lua require'dap'.continue()<CR>
-- inoremap <F5> <ESC>:lua require('nvim-dap-projects').search_project_config()<CR>:lua require("dapui").open()<CR>:lua require'dap'.continue()<CR>
-- nnoremap <F6> :lua require'dap'.step_over()<CR>
-- inoremap <F6> <ESC>:lua require'dap'.step_over()<CR>
-- nnoremap <F7> :lua require'dap'.step_into()<CR>
-- inoremap <F7> <ESC>:lua require'dap'.step_into()<CR>
-- nnoremap <F8> :lua require'dap'.step_out()<CR>
-- inoremap <F8> <ESC>:lua require'dap'.step_out()<CR>
-- nnoremap <F9> :lua require'dap'.toggle_breakpoint()<CR>
-- inoremap <F9> <ESC>:lua require'dap'.toggle_breakpoint()<CR>
-- nnoremap <F10> :lua require'dap'.terminate()<CR>:lua require'dapui'.close()<CR>
-- inoremap <F10> <ESC>:lua require'dap'.terminate()<CR>:lua require'dapui'.close()<CR>
