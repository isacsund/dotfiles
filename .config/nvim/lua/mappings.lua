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

-- Switch barbar buffers
nnoremap("<Leader>L", ":BufferPrevious<CR>")
nnoremap("<Leader>H", ":BufferNext<CR>")

-- Telescope
nnoremap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nnoremap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nnoremap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
nnoremap("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- No arrow keys
nnoremap("<up>", "<nop>")
nnoremap("<down>", "<nop>")
nnoremap("<left>", "<nop>")
nnoremap("<right>", "<nop>")
inoremap("<up>", "<nop>")
inoremap("<down>", "<nop>")
inoremap("<left>", "<nop>")
inoremap("<right>", "<nop>")

