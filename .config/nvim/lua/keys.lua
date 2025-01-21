-- Leader
vim.api.nvim_set_keymap("n", "<Space>", "<nop>", { noremap = true })
vim.g.mapleader = " "

vim.cmd([[

" Leader mappings
nnoremap <leader>q :qa<CR>
nnoremap <leader>s :e ~/scratch/scratch.md<CR>
nnoremap <leader>rl :w<CR> :luafile %<CR>
nnoremap <leader>rr :!
nnoremap <leader><leader> <cmd>Telescope find_files hidden=true<CR>
nnoremap <leader>i <cmd>Telescope find_files hidden=true no_ignore=true<CR>
nnoremap <leader>f <cmd>Telescope live_grep<CR>
nnoremap <leader>b <cmd>Telescope buffers<CR>
nnoremap <leader>l <cmd>Telescope oldfiles<CR>
nnoremap <leader>d <cmd>Telescope diagnostics<CR>
nnoremap <leader>h <cmd>Telescope help_tags<CR>
nnoremap <leader>gs :Telescope git_status<CR>
nnoremap <leader>gc :Telescope git_commits<CR>
nnoremap <leader>gr :Telescope git_branches<CR>
nnoremap <leader>j :Telescope jumplist<CR>
nnoremap <leader>gb :GBrowse<CR>
vnoremap <leader>gb :GBrowse<CR>
nnoremap <leader>gl :GBrowse<CR>
vnoremap <leader>gl :GBrowse<CR>
nnoremap <leader>gm :G blame<CR>
noremap <leader>gg :Neogit<CR>
nnoremap <leader>/ <Plug>(comment_toggle_linewise_current)
vnoremap <leader>/ <Plug>(comment_toggle_linewise_visual)
nnoremap <leader>- <C-w>s
nnoremap <leader>\ <C-w>v
nnoremap <leader>ww <C-w>c
nnoremap <leader>ctt :TestNearest<CR>
nnoremap <leader>ctT :TestFile<CR>
nnoremap <leader>cta :TestSuite<CR>
nnoremap <leader>ctl :TestLast<CR>
nnoremap <leader>co :TodoTelescope<CR>
nnoremap <leader>tt <cmd>NvimTreeToggle<CR>

" Mac command mappings
" Option-s in Mac
nnoremap ß :w<CR>
inoremap ß <ESC>:w<CR>a
" Option-a in Mac
nnoremap å ggVG
inoremap å <ESC>ggVG
" Option-f in Mac
nnoremap ƒ <cmd>Telescope current_buffer_fuzzy_find<CR>
" Option-w in Mac
nnoremap ∑ :Bdelete<CR>
" vnoremap <D-c> "*y
" inoremap <D-v> <ESC>"*pa
" nnoremap <D-v> "*p

" Window/buffer navigation mappings
nnoremap <silent> <C-h> :<C-U>TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :<C-U>TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :<C-U>TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :<C-U>TmuxNavigateRight<CR>
nnoremap <silent> <C-\> :<C-U>TmuxNavigatePrevious<CR>
inoremap <silent> <C-h> <ESC>:<C-U>TmuxNavigateLeft<CR>
inoremap <silent> <C-j> <ESC>:<C-U>TmuxNavigateDown<CR>
inoremap <silent> <C-k> <ESC>:<C-U>TmuxNavigateUp<CR>
inoremap <silent> <C-l> <ESC>:<C-U>TmuxNavigateRight<CR>
inoremap <silent> <C-\> <ESC>:<C-U>TmuxNavigatePrevious<CR>

" Function key mappings
nnoremap <F5> :lua require('nvim-dap-projects').search_project_config()<CR>:lua require("dapui").open()<CR>:lua require'dap'.continue()<CR>
inoremap <F5> <ESC>:lua require('nvim-dap-projects').search_project_config()<CR>:lua require("dapui").open()<CR>:lua require'dap'.continue()<CR>
nnoremap <F6> :lua require'dap'.step_over()<CR>
inoremap <F6> <ESC>:lua require'dap'.step_over()<CR>
nnoremap <F7> :lua require'dap'.step_into()<CR>
inoremap <F7> <ESC>:lua require'dap'.step_into()<CR>
nnoremap <F8> :lua require'dap'.step_out()<CR>
inoremap <F8> <ESC>:lua require'dap'.step_out()<CR>
nnoremap <F9> :lua require'dap'.toggle_breakpoint()<CR>
inoremap <F9> <ESC>:lua require'dap'.toggle_breakpoint()<CR>
nnoremap <F10> :lua require'dap'.terminate()<CR>:lua require'dapui'.close()<CR>
inoremap <F10> <ESC>:lua require'dap'.terminate()<CR>:lua require'dapui'.close()<CR>

" Other mappings
nnoremap vv <C-w>v
" nnoremap <PageUp> <Cmd>lua require('neoscroll').scroll(-vim.api.nvim_win_get_height(0), true, 0)<CR>
" nnoremap <PageDown> <Cmd>lua require('neoscroll').scroll(vim.api.nvim_win_get_height(0), true, 0)<CR>
nnoremap <Home> <Cmd>lua require('neoscroll').scroll(-vim.api.nvim_win_get_height(0), true, 0)<CR>
nnoremap <End> <Cmd>lua require('neoscroll').scroll(vim.api.nvim_win_get_height(0), true, 0)<CR>
" nnoremap <C-Up> <Cmd>lua require('neoscroll').ctrl_u({duration = 100})<CR>
" nnoremap <C-Down> <Cmd>lua require('neoscroll').ctrl_d({duration = 100})<CR>
nnoremap <C-Up> <Cmd>lua require('neoscroll').scroll(-0.25, { move_cursor=true; duration = 100 })<CR>
nnoremap <C-Down> <Cmd>lua require('neoscroll').scroll(0.25, { move_cursor=true; duration = 100 })<CR>
nnoremap <PageUp> <Cmd>lua require('neoscroll').scroll(-0.25, { move_cursor=true; duration = 100 })<CR>
nnoremap <PageDown> <Cmd>lua require('neoscroll').scroll(0.25, { move_cursor=true; duration = 100 })<CR>
nnoremap - :Oil<CR>
nnoremap <leader>m :Telescope marks<CR>

]])
