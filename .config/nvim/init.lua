vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.have_nerd_font = true

vim.opt.number = true

vim.opt.mouse = "a"
vim.opt.mousescroll = "ver:2,hor:1"

vim.opt.showmode = false

vim.opt.breakindent = true

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"

vim.opt.cursorline = true

vim.o.guicursor = "r-cr-o:hor20,n-v-c-sm:block-blinkon100,i-ci-ve:ver10-blinkon100"

vim.opt.scrolloff = 10

vim.opt.tabstop = 4
vim.opt.expandtab = true

vim.o.wildoptions = "pum,tagfile,fuzzy"

vim.o.winborder = "rounded"

-- Hack to fix double borders until winborder is better supported by telescope
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopeFindPre",
  callback = function()
    vim.opt_local.winborder = "none"
    vim.api.nvim_create_autocmd("WinLeave", {
      once = true,
      callback = function()
        vim.opt_local.winborder = "rounded"
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})

require("load_lazy")
require("keys")

local hl = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextInfo" })
-- local color = string.format("#%06x", hl.bg)
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = color })
