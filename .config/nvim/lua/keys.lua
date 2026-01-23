vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "\\", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("v", "\\", "gc", { remap = true, desc = "Comment lines" })

vim.keymap.set("n", "<CR>", "G", { remap = true, desc = "Goto line" })

vim.keymap.set("n", "<leader>s", ":w<CR>", { desc = "Save neovim" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

vim.keymap.set("n", "<leader>aa", "ggVG", { desc = "Select all" })
-- vim.keymap.set("n", "<leader>ay", ":%y<CR>", { desc = "Yank all" })
vim.keymap.set("n", "<leader>ay", ":%y+<CR>", { desc = "Yank all to system clipboard" })
vim.keymap.set("n", "<leader>ad", ":%d<CR>", { desc = "Delete all" })

vim.keymap.set("n", "<leader>bd", ":Bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bl", ":b#<CR>", { desc = "Goto last buffer" })

vim.keymap.set("n", "<leader>q", ":qa<CR>", { desc = "Quit neovim" })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Quit neovim without saving" })

vim.keymap.set("n", "<leader>ww", function()
  local current_win = vim.fn.winnr()
  local prev_win = vim.fn.winnr("#")
  if prev_win ~= current_win then
    vim.cmd("wincmd p")
  else
    vim.cmd("wincmd w")
  end
end, { desc = "Switch to last or next window" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>wV", "<cmd>leftabove vsplit<cr>", { desc = "Split window vertically (left)" })
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>wd", "<C-w>q", { desc = "Delete window" })

vim.keymap.set("n", "<leader>jd", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Goto next diagnostic" })
vim.keymap.set("n", "<leader>kd", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Goto previous diagnostic" })
vim.keymap.set("v", "<leader>o", ":sort<CR>", { desc = "Order" })

-- Toggle virtual line diagnostics
vim.keymap.set("n", "<leader>tl", function()
  vim.diagnostic.config({
    virtual_lines = not vim.diagnostic.config().virtual_lines,
  })
end, { desc = "Toggle virtual line diagnostics" })

-- Toggle virtual text diagnostics
vim.keymap.set("n", "<leader>tt", function()
  vim.diagnostic.config({
    virtual_text = not vim.diagnostic.config().virtual_text,
  })
end, { desc = "Toggle virtual text diagnostics" })

-- Toggle inlay hints
vim.keymap.set("n", "<leader>th", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

-- Show floating diagnostics on hover
local diagnostics_hover_enabled = true
local current_diagnostic_win = nil
local function show_diagnostics_on_hover()
  if diagnostics_hover_enabled then
    local _, win_id = vim.diagnostic.open_float({ focus = false, focusable = true, scope = "cursor" })
    current_diagnostic_win = win_id
  end
end
vim.api.nvim_create_autocmd({ "CursorHold" }, { callback = show_diagnostics_on_hover })

-- Reload diagnostic float window after the diagnostics have changed
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function()
    if current_diagnostic_win and vim.api.nvim_win_is_valid(current_diagnostic_win) then
      vim.api.nvim_win_close(current_diagnostic_win, false)
      current_diagnostic_win = nil
    end

    if vim.fn.mode() ~= "i" then
      show_diagnostics_on_hover()
    end
  end,
})

-- Keymap to toggle floating diagnostics
vim.keymap.set("n", "<leader>tf", function()
  diagnostics_hover_enabled = not diagnostics_hover_enabled
end, { desc = "Toggle floating diagnostics" })

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
