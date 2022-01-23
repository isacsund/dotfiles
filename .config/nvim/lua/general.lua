-- Use space as leader key
vim.g.mapleader = " "

-- Enable syntax highlighting
vim.opt.syntax = "enable"

-- Do not wrap long lines
vim.opt.wrap = false

-- Allow hidden buffers
vim.opt.hidden = true

-- Use utf-8
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Better display for messages
vim.opt.cmdheight = 2

-- Faster diagnostic messages
vim.opt.updatetime = 300

-- Enable mouse usage (all modes) in terminals
vim.opt.mouse = "a"

-- Sane splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tabs as 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true

-- Auto indent
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show column
vim.opt.colorcolumn = "100"

-- Prevent buffer moving when adding/deleting sign.
vim.opt.signcolumn = "yes"

-- Indicate that a dark background should be used
vim.opt.background = "dark"

-- Always use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable colors in the terminal UI
vim.opt.termguicolors = true

-- Permanent undo
vim.opt.undodir = os.getenv("HOME") .. "/.vimdid"
vim.opt.undofile = true

-- Decent wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"

-- Show whitespace characters
vim.opt.listchars = {
  space = "⋅",
  eol = "↴",
  tab = "__",
  trail = "•",
  extends = "❯",
  precedes = "❮",
  nbsp = "_",
}
vim.opt.list = true
