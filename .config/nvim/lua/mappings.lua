-- Wrapper functions
local nnoremap = function(lhs, rhs, silent)
  vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = silent })
end

local inoremap = function(lhs, rhs)
  vim.api.nvim_set_keymap("i", lhs, rhs, { noremap = true })
end

local nmap = function(lhs, rhs)
  vim.api.nvim_set_keymap("n", lhs, rhs, {})
end

local map = function(lhs, rhs)
  vim.api.nvim_set_keymap("", lhs, rhs, {})
end

-- Quick-save
nmap("<leader>w", ":w<CR>")

-- Quickly insert an empty new line without entering insert mode
nnoremap("<Leader>o", "o<Esc>")
nnoremap("<Leader>O", "O<Esc>")

-- Jump to start and end of line using the home row keys
map("H", "^")
map("L", "$")

-- <Leader><Leader> toggles between buffers
nnoremap("<Leader><Leader>", "<c-^>")

-- Move by line
nnoremap("j", "gj")
nnoremap("k", "gk")

-- No arrow keys
nnoremap("<up>", "<nop>")
nnoremap("<down>", "<nop>")
inoremap("<up>", "<nop>")
inoremap("<down>", "<nop>")
inoremap("<left>", "<nop>")
inoremap("<right>", "<nop>")
